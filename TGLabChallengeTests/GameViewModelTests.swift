//
//  TGLabChallengeTests.swift
//  TGLabChallengeTests
//
//  Created by Sérgio César Lira Júnior on 17/10/25.
//

import XCTest
@testable import TGLabChallenge
import NBAService
final class GameViewModelTests: XCTestCase {
    private var vm: GamesViewModel!
    private var mockNBAService: MockNBAService!
    private var gamesDTO: [GameDTO]!
    private var teamsDTO: [TeamDTO]!
    override func setUp() {
        super.setUp()
        mockNBAService = MockNBAService()
        vm = GamesViewModel(service: mockNBAService)
        teamsDTO = [
            TeamDTO(id: 1, fullName: "Internacional", city: "Porto Alegre", conference: "South"),
            TeamDTO(id: 2, fullName: "Flamengo", city: "Rio de Janeiro", conference: "East"),
            TeamDTO(id: 3, fullName: "Santos", city: "Santos", conference: "Center"),
            ]
        gamesDTO = [
            GameDTO(id: 11, homeTeam: teamsDTO[0], homeTeamScore: 39, visitorTeam: teamsDTO[1], visitorTeamScore: 12),
            GameDTO(id: 12, homeTeam: teamsDTO[2], homeTeamScore: 32, visitorTeam: teamsDTO[1], visitorTeamScore: 8),
            GameDTO(id: 13, homeTeam: teamsDTO[1], homeTeamScore: 25, visitorTeam: teamsDTO[2], visitorTeamScore: 28),
        ]
    }

    override func tearDown() {
        vm = nil
        mockNBAService = nil
        teamsDTO = nil
        gamesDTO = nil
        super.tearDown()
    }

    @MainActor
    func testLoadInitialData_Success() async {
        //Arrange
        let fakeGameList = gamesDTO
        let expectedResponse: [GameModel] = gamesDTO.map{GameModel(by: $0)}
        mockNBAService.gameList = .success(fakeGameList!)
        let expectation = XCTestExpectation(description: "waiting for Games")

        //Act
        vm.loadInitialData(for: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)

        //Assert
        XCTAssertEqual(vm.gamesList, expectedResponse)
    }

    @MainActor
    func testLoadInitialData_Fail() async {
        //Arrange
        let expectedResponse: [GameModel] = []
        mockNBAService.gameList = .failure(MockErrors.networkError)
        let expectation = XCTestExpectation(description: "waiting for Failure")

        //Act
        vm.loadMoreData(for: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        // Assert
        XCTAssertEqual(vm.gamesList, expectedResponse)
    }

    @MainActor
    func testLoadMoreData_Success() async {
        //Arrange
        let fakeGameList: [GameDTO] = [gamesDTO[1], gamesDTO[2]]
        vm.gamesList = [GameModel(by: gamesDTO[0])]
        let expectedResponse: [GameModel] = gamesDTO.map{GameModel(by: $0)}
        let expectation = XCTestExpectation(description: "waiting for new Games")
        mockNBAService.gameList = .success(fakeGameList)

        //Act
        vm.loadMoreData(for: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)

        //Assert
        XCTAssertEqual(vm.gamesList, expectedResponse)
    }

    @MainActor
    func testLoadMoreData_Failure() async {
        //Arrange
        vm.gamesList = [GameModel(by: gamesDTO[0])]
        let expectedResponse: [GameModel] = [GameModel(by: gamesDTO[0])]
        let expectation = XCTestExpectation(description: "waiting for Failure")
        mockNBAService.gameList = .failure(MockErrors.networkError)
        //Act
        vm.loadMoreData(for: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        //Assert
        XCTAssertEqual(vm.gamesList, expectedResponse)
    }

    @MainActor
    func testLoadMoreData_NoMoreData() async {
        //Arrange
        let expectedList: [GameModel] = gamesDTO.map{GameModel(by: $0)}
        let expectedHasMoreData = false
        vm.gamesList = gamesDTO.map{GameModel(by: $0)}
        let expectation = XCTestExpectation(description: "waiting for no more data")
        mockNBAService.gameList = .success([])
        //Act
        vm.loadMoreData(for: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        //Assert
        XCTAssertEqual(vm.gamesList, expectedList)
        XCTAssertEqual(vm.hasMoreData, expectedHasMoreData)
    }

}
