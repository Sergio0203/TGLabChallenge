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
    var teamsList: [TeamDTO] = []

    func fetchTeams() {
        Task {
            var auxTeams: [TeamDTO] = []
            do {
                auxTeams = try await service.getTeams()
                await MainActor.run {
                    self.teamsList = auxTeams
                    print(self.teamsList)
                }
            }
            catch let error{
                print("Error: \(error):", error.localizedDescription)
            }
        }
    }
}
