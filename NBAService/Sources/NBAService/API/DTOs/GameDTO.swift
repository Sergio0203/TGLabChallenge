//
//  GamesDTO.swift
//  NBAService
//
//  Created by Sérgio César Lira Júnior on 17/10/25.
//

public struct GameDTO: Codable, Identifiable {
    public let id: Int
    public let homeTeam: TeamDTO
    public let homeTeamScore: Int
    public let visitorTeam: TeamDTO
    public let visitorTeamScore: Int

    enum CodingKeys: String, CodingKey {
        case id
        case homeTeam = "home_team"
        case homeTeamScore = "home_team_score"
        case visitorTeam = "visitor_team"
        case visitorTeamScore = "visitor_team_score"
    }
}
