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
    @ObservationIgnored private let service = NBAService()
    var gamesList: [GameModel] = []

    var isLoading = false
    private var hasMoreData = true

    private func fetchGames(from teamID: Int) {
        guard !isLoading, hasMoreData else { return }

        isLoading = true

        Task {
            do {
                let response = try await service.getGames(forTeamId: teamID, cursor: gamesList.last?.id)
                if response.isEmpty {
                    self.hasMoreData = false
                }
                else {
                    var newGames: [GameModel] = []
                    response.forEach { game in
                        newGames.append(GameModel(by: game))
                    }
                    await MainActor.run {
                        self.gamesList += newGames
                        self.isLoading = false
                    }
                }
            } catch {
                print("Error fetching games: \(error)")
                await MainActor.run {
                    self.isLoading = false
                }
            }
        }
    }

    func loadInitialData(for teamID: Int) {
        if gamesList.isEmpty {
            fetchGames(from: teamID)
        }
    }

    func loadMoreData(for teamID: Int) {
        fetchGames(from: teamID)
    }
}
