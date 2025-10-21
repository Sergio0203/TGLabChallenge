//
//  GamesView.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 20/10/25.
//

import SwiftUI

struct GamesView: View {
    @State private var vm = GamesViewModel()
    let selectedId: Int
    let teamName: String
    private let columns: [CustomTableColumn<GameModel>] = [
        .init(maxWidth: 60, title: { TableCell("Home Name") }) { game in
            TableCell(game.homeName)
        },
        .init(maxWidth: 60, title: { TableCell("Home Score") }) { game in
            TableCell(String(game.homeScore))
        },
        .init(maxWidth: 60, title: { TableCell("Visitor Name") }) { game in
            TableCell(game.visitorName)
        },
        .init(maxWidth: 60, title: { TableCell("Visitor Score") }) { game in
            TableCell(String(game.visitorScore))
        },
    ]
    var body: some View {
        CustomTable(items: vm.gamesList, columns: columns)
            .onAppear {
                vm.fetchGames(from: selectedId)
            }
            .toolbar(.hidden, for: .tabBar)
    }

}

#Preview {
    GamesView(selectedId: 1, teamName: "Xabulaba")
}
