//
//  TeamsViewViewModel.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//
import SwiftUI
import NBAService

enum SortingCriteria: String, CaseIterable {
    case name = "Name"
    case conference = "Conference"
    case city = "City"
}

@Observable
final class TeamsViewModel {
    private let service = NBAService()
    var teamsList: [TeamModel] = []
    var selectedTeam: TeamModel?
    var sortingCriteria: SortingCriteria = .name
    var showSheet: Bool = false
    private func fetchTeams() {
        Task {
            var auxTeams: [TeamModel] = []
            do {
                let teamsResponse = try await service.getTeams()
                teamsResponse.forEach({ team in
                    auxTeams.append(.init(by: team))
                })
                await MainActor.run {
                    self.teamsList = auxTeams
                    sortTeamList()
                }
            }
            catch let error{
                print("Error: \(error):", error.localizedDescription)
            }
        }
    }
    func loadInitialData() {
        if teamsList.isEmpty {
            fetchTeams()
        }
    }

    func sortTeamList() {
        switch sortingCriteria{
        case .name:
            teamsList.sort { $0.name < $1.name }
        case .conference:
            teamsList.sort { $0.conference < $1.conference }
        case .city:
            teamsList.sort { $0.city < $1.city }
        }
    }
}
