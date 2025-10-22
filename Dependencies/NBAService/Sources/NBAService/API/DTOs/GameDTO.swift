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

    public init(id: Int, homeTeam: TeamDTO, homeTeamScore: Int, visitorTeam: TeamDTO, visitorTeamScore: Int) {
        self.id = id
        self.homeTeam = homeTeam
        self.homeTeamScore = homeTeamScore
        self.visitorTeam = visitorTeam
        self.visitorTeamScore = visitorTeamScore
    }
    enum CodingKeys: String, CodingKey {
        case id
        case homeTeam = "home_team"
        case homeTeamScore = "home_team_score"
        case visitorTeam = "visitor_team"
        case visitorTeamScore = "visitor_team_score"
    }
}
