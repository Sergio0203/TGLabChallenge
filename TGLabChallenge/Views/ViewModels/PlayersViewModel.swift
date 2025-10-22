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
    @ObservationIgnored private let service = NBAService()
    var playersList: [PlayerModel] = []
    var name: String = ""
    var selectedPlayer: PlayerModel?
    var isLoading: Bool = false
    @ObservationIgnored private var searchTask: Task<Void, Never>?

    @MainActor
    private func fetchPlayers() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let playersResponse = try await service.getPlayers(withName: name)
            playersList = playersResponse.map(PlayerModel.init)
        } catch {
            print("Error fetching players: \(error.localizedDescription)")
            playersList = []
        }
    }

    func loadInitialData() {
        if playersList.isEmpty {
            Task {
                await fetchPlayers()
            }
        }
    }

    func search() {
        searchTask?.cancel()
        searchTask = Task {
            do {
                try await Task.sleep(for: .seconds(1.5))
                await fetchPlayers()
            } catch {
                
            }
        }
    }

    func submitSearch() {
        searchTask?.cancel()
        Task {
            await fetchPlayers()
        }
    }
}
