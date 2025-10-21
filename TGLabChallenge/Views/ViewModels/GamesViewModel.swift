//
//  TeamsViewViewModel.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//
import SwiftUI
import NBAService

@Observable
final class GamesViewModel {
    private let service = NBAService()
    var gamesList: [GameModel] = []

    func fetchGames(from teamID: Int) {
        Task {
            var auxPlayers: [GameModel] = []
            do {
                let response = try await service.getGames(forTeamId: teamID)
                response.forEach { team in
                    auxPlayers.append(GameModel(by: team))
                }
                await MainActor.run {
                    self.gamesList = auxPlayers
                }
            } catch {
                print("Error fetching players: \(error)")
            }
        }
    }
}
