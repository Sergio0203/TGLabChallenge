//
//  MockNBAService.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 21/10/25.
//
import NBAService

enum MockErrors: Error {
    case NetworkError

}

final class MockNBAService: NBAServiceProtocol {
    var teamList: Result<[TeamDTO], Error>?
    var gameList: Result<[GameDTO], Error>?
    var playerList: Result<[PlayerDTO], Error>?

    func getTeams() async throws -> [TeamDTO] {
        switch teamList {
        case .success(let teams):
            return teams
        case .failure(let error):
            throw error
        case .none:
            fatalError("TeamList not configured")
        }
    }

    func getGames(forTeamId id: Int, cursor: Int?) async throws -> [GameDTO] {
        switch gameList {
        case .success(let games):
            return games
        case .failure(let error):
            throw error
        case .none:
            fatalError("GameList not configured")
        }
    }

    func getPlayers(withName name: String) async throws -> [PlayerDTO] {
        switch playerList {
        case .success(let players):
            return players
        case .failure:
            fatalError("No players found")
        case .none:
            fatalError("PlayerList not configured")
        }
    }


}
