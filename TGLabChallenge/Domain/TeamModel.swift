//
//  TeamModel.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//

import NBAService
import Foundation

struct TeamModel: Codable, Identifiable {
    let id: Int
    let name: String
    let conference: String
    let city: String

    init(id: Int, name: String, conference: String, city: String) {
        self.id = id
        self.name = name
        self.conference = conference
        self.city = city
    }
}

extension TeamModel {
    init(by team: TeamDTO) {
        id = team.id
        name = team.fullName
        let noSpacesConference = team.conference.trimmingCharacters(in: .whitespacesAndNewlines)
        conference = noSpacesConference.isEmpty ? "---" : noSpacesConference
        city = team.city.isEmpty ? "---" : team.city
    }
}
