//
//  GameModel.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 20/10/25.
//
import NBAService

struct GameModel: Identifiable, Equatable {
    let id: Int
    let homeName: String
    let visitorName: String
    let homeScore: Int
    let visitorScore: Int
}

extension GameModel{
    init(by: GameDTO) {
        id = by.id
        homeName = by.homeTeam.fullName
        visitorName = by.visitorTeam.fullName
        homeScore = by.homeTeamScore
        visitorScore = by.visitorTeamScore
    }
}
