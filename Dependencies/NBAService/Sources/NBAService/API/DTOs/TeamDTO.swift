//
//  TeamDTO.swift
//  NBAService
//
//  Created by Sérgio César Lira Júnior on 17/10/25.
//
public struct TeamDTO: Codable, Identifiable {
    public let id: Int
    public let fullName: String
    public let city: String
    public let conference: String

    public init(id: Int, fullName: String, city: String, conference: String) {
        self.id = id
        self.fullName = fullName
        self.city = city
        self.conference = conference
    }

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case city
        case conference
    }
}
