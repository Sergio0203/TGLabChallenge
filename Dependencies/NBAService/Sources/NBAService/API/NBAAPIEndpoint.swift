//
//  NBAAPIEndpoint.swift
//  NBAService
//
//  Created by Sérgio César Lira Júnior on 17/10/25.
//

import Foundation
import Client
enum NBAAPIEndpoint: APIEndpointProtocol {

    case getTeams
    case getGames(teamID: Int, cursor: Int?)
    case searchPlayers(name: String)

    var baseUrl: BaseUrls {
        return .baseUrl
    }
    var path: String {
        switch self {
        case .getTeams:
            return "teams"
        case .getGames:
            return "games"
        case .searchPlayers:
            return "players"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getTeams, .getGames, .searchPlayers:
            return .get
        }
    }

    var headers: [String: String] {
        return ["Content-Type": "application/json", "Authorization": "1942ca94-ee06-44a9-b998-1230efbfb898"]
    }

    var parameters: [String : Any] {
        [:]
    }

    var query: [String : String] {
        switch self {
        case .getTeams:
            return [:]
        case .getGames(let teamID, let cursor):
            return ["team_ids[]": String(teamID), "next_cursor": "\(cursor)"]
        case .searchPlayers(let name):
            return ["search": name]
        }
    }
}
