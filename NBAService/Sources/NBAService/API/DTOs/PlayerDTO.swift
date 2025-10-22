//
//  PlayersDTO.swift
//  NBAService
//
//  Created by Sérgio César Lira Júnior on 17/10/25.
//

public struct PlayerDTO: Codable {
    public let firstName: String
    public let lastName: String
    public let team: TeamDTO
    public let id: Int
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName =  "last_name"
        case team
        case id
    }
}
