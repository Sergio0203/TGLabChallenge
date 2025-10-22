//
//  PlayersViewModelTests.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 22/10/25.
//

import XCTest
@testable import TGLabChallenge
import NBAService
final class TeamViewModelTests: XCTestCase {
    private var vm: TeamsViewModel!
    private var mockNBAService: MockNBAService!
    private var teamsDTO: [TeamDTO]!
    override func setUp() {
        super.setUp()
        mockNBAService = MockNBAService()
        vm = TeamsViewModel(service: mockNBAService)
        teamsDTO = [
            TeamDTO(id: 1, fullName: "Internacional", city: "Porto Alegre", conference: "South"),
            TeamDTO(id: 2, fullName: "Flamengo", city: "Rio de Janeiro", conference: "East"),
            TeamDTO(id: 3, fullName: "Santos", city: "Santos", conference: "Center"),
        ]
    }

    override func tearDown() {
        vm = nil
        mockNBAService = nil
        teamsDTO = nil
        super.tearDown()
    }

    @MainActor
    func testLoadInitialData_Success() async {
        //Arrange
        let fakeTeamsList: [TeamDTO] = teamsDTO
        let expectedResponse: [TeamModel] = teamsDTO.map{TeamModel(by: $0)}.sorted{ $0.name < $1.name }
        mockNBAService.teamList = .success(fakeTeamsList)
        let expectation = XCTestExpectation(description: "waiting for Teams")

        //Act
        vm.loadInitialData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)

        //Assert
        XCTAssertEqual(vm.teamsList, expectedResponse)
    }

    @MainActor
    func testLoadInitialData_Fail() async {
        //Arrange
        let expectedResponse: [TeamModel] = []
        mockNBAService.teamList = .failure(MockErrors.networkError)
        let expectation = XCTestExpectation(description: "waiting for Failure")

        //Act
        vm.loadInitialData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 2.0)
        // Assert
        XCTAssertEqual(vm.teamsList, expectedResponse)
    }

    func testSortTeams_ByName() {
        //Arrange
        vm.teamsList = teamsDTO.map{TeamModel(by: $0)}
        let expectedResponse: [TeamModel] = teamsDTO.map{TeamModel(by: $0)}.sorted{ $0.name < $1.name }
        vm.sortingCriteria = .name

        //Act
        vm.sortTeamList()

        //Assert
        XCTAssertEqual(vm.teamsList, expectedResponse)
    }

    func testSortTeams_ByConference() {
        //Arrange
        vm.teamsList = teamsDTO.map{TeamModel(by: $0)}
        let expectedResponse: [TeamModel] = teamsDTO.map{TeamModel(by: $0)}.sorted{ $0.conference < $1.conference }
        vm.sortingCriteria = .conference

        //Act
        vm.sortTeamList()

        //Assert
        XCTAssertEqual(vm.teamsList, expectedResponse)
    }

    func testSortTeams_ByCity() {
        //Arrange
        vm.teamsList = teamsDTO.map{TeamModel(by: $0)}
        let expectedResponse: [TeamModel] = teamsDTO.map{TeamModel(by: $0)}.sorted{ $0.city < $1.city }
        vm.sortingCriteria = .city

        //Act
        vm.sortTeamList()

        //Assert
        XCTAssertEqual(vm.teamsList, expectedResponse)
    }
}
