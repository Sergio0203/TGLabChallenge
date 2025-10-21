//
//  PlayerModel.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 20/10/25.
//
import NBAService
struct PlayerModel: Identifiable, Hashable {
    let id: Int
    let firstName: String
    let lastName: String
    let team: TeamModel
}

extension PlayerModel {
    init(by player: PlayerDTO) {
        let team = TeamModel(by: player.team)
        self.team = team
        self.firstName = player.firstName
        self.lastName = player.lastName
        self.id = player.id
    }
}

