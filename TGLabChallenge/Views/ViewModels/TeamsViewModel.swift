//
//  TeamsViewViewModel.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//
import SwiftUI
import NBAService

@Observable
final class TeamsViewModel {
    private let service = NBAService()
    var teamsList: [TeamModel] = []
    var selectedTeam: TeamModel?

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

}
