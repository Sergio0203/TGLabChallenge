//
//  PlayersViewModel.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 20/10/25.
//

import SwiftUI
import NBAService

@Observable
final class PlayersViewModel {
    private let service = NBAService()
    var playersList: [PlayerModel] = []
    var name: String = ""
    var selectedPlayer: PlayerModel?

    private func fetchPlayers() {
        Task {
            var auxPlayers: [PlayerModel] = []
            do {
                let playersResponse = try await service.getPlayers(withName: name)
                playersResponse.forEach({ player in
                    auxPlayers.append(.init(by: player))
                })
                await MainActor.run {
                    playersList = auxPlayers
                }
            }
        }
    }

    func loadInitialData() {
        if playersList.isEmpty {
            fetchPlayers()
        }
    }
}
