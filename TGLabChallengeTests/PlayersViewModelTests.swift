//
//  PlayersViewModelTests.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 22/10/25.
//

import XCTest
@testable import TGLabChallenge
import NBAService
final class PlayersViewModelTests: XCTestCase {
    private var vm: PlayersViewModel!
    private var mockNBAService: MockNBAService!
    private var playersDTO: [PlayerDTO]!
    private var teamsDTO: [TeamDTO]!
    override func setUp() {
        super.setUp()
        mockNBAService = MockNBAService()
        vm = PlayersViewModel(service: mockNBAService)
        teamsDTO = [
            TeamDTO(id: 1, fullName: "Internacional", city: "Porto Alegre", conference: "South"),
            TeamDTO(id: 2, fullName: "Flamengo", city: "Rio de Janeiro", conference: "East"),
            TeamDTO(id: 3, fullName: "Santos", city: "Santos", conference: "Center"),
        ]
        playersDTO = [
            PlayerDTO(firstName: "Lionel", lastName: "Messi", team: teamsDTO[0], id: 11),
            PlayerDTO(firstName: "Cristiano", lastName: "Ronaldo", team: teamsDTO[1], id: 12),
            PlayerDTO(firstName: "Neymar", lastName: "Junior", team: teamsDTO[2], id: 13),
        ]
    }

    override func tearDown() {
        vm = nil
        mockNBAService = nil
        teamsDTO = nil
        playersDTO = nil
        super.tearDown()
    }

    @MainActor
    func testLoadInitialData_Success() async {
        //Arrange
        let fakePlayersList: [PlayerDTO] = playersDTO
        let expectedResponse: [PlayerModel] = playersDTO.map{PlayerModel(by: $0)}
        mockNBAService.playerList = .success(fakePlayersList)
        let expectation = XCTestExpectation(description: "waiting for Players")

        //Act
        vm.loadInitialData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)

        //Assert
        XCTAssertEqual(vm.playersList, expectedResponse)
    }

    @MainActor
    func testLoadInitialData_Fail() async {
        //Arrange
        let expectedResponse: [PlayerModel] = []
        mockNBAService.playerList = .failure(MockErrors.networkError)
        let expectation = XCTestExpectation(description: "waiting for Failure")

        //Act
        vm.loadInitialData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        // Assert
        XCTAssertEqual(vm.playersList, expectedResponse)
    }

    @MainActor
    func testSubmit_Success() async {
        //Arrange
        let expectedResponse: [PlayerModel] = [.init(by: playersDTO[1])]
        let fakePlayersList: [PlayerDTO] = [playersDTO[1]]
        vm.playersList = playersDTO.map{PlayerModel(by: $0)}
        mockNBAService.playerList = .success(fakePlayersList)
        let expectation = XCTestExpectation(description: "waiting for Players")

        //Act
        vm.name = "teste"
        vm.submitSearch()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)

        //Assert
        XCTAssertEqual(vm.playersList, expectedResponse)
    }

    @MainActor
    func testSubmit_Failure() async {
        //Arrange
        let expectedResponse: [PlayerModel] = playersDTO.map{PlayerModel(by: $0)}
        vm.playersList = playersDTO.map{PlayerModel(by: $0)}
        let expectation = XCTestExpectation(description: "waiting for Players failure")
        mockNBAService.playerList = .failure(MockErrors.networkError)

        //Act
        vm.name = "teste"
        vm.submitSearch()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        //Assert
        XCTAssertEqual(vm.playersList, expectedResponse)
    }
}
