//
//  TeamsViewViewModel.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//
import SwiftUI
import NBAService

@Observable
final class NBAViewModel {
    private let service = NBAService()
    var teamsList: [TeamModel] = []

    func fetchTeams() {
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
}
