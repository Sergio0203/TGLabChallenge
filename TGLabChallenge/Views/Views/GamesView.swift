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
        ScrollView {
            if !vm.gamesList.isEmpty {
                LazyVStack {
                    CustomTable(
                        items: vm.gamesList,
                        columns: columns
                    )
                    ProgressView()
                        .onAppear{
                            vm.loadMoreData(for: selectedId)
                        }
                }
            } else {
                ProgressView()
            }
        }
        .navigationTitle(teamName)
        .onAppear {
            if vm.gamesList.isEmpty {
                vm.loadInitialData(for: selectedId)
            }
        }
        .toolbar(.hidden, for: .tabBar)
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        GamesView(selectedId: 1, teamName: "Test")
    }
}
#endif
