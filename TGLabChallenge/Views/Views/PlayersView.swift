//
//  PlayersView.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 20/10/25.
//
import SwiftUI

struct PlayersView: View {
    @State private var vm = PlayersViewModel()

    private let columns: [CustomTableColumn<PlayerModel>] = [
        .init(maxWidth: 80, title: { TableCell("First Name") }) { player in
            TableCell(player.firstName)
        },
        .init(maxWidth: 80, title: { TableCell("Last Name") }) { player in
            TableCell(player.lastName)
        },
        .init(maxWidth: 100, title: { TableCell("Team") }) { player in
            TableCell(player.team.name)
        },
    ]

    var body: some View {
        NavigationStack {
            Group {
                if vm.isLoading {
                    ProgressView("Searching...")
                } else if vm.playersList.isEmpty {
                    ContentUnavailableView {
                        Label("No Players Found", systemImage: "person.3.slash.fill")
                    } description: {
                        if !vm.name.isEmpty {
                            Text("No results for \"\(vm.name)\". Try another name.")
                        } else {
                            Text("There are no players to show right now.")
                        }
                    }
                } else {
                    CustomTable(
                        items: vm.playersList,
                        columns: columns,
                        onRowTapped: { player in
                            vm.selectedPlayer = player
                        }
                    )
                    .navigationDestination(item: $vm.selectedPlayer) { player in
                        GamesView(selectedId: player.team.id, teamName: player.team.name)
                    }
                }
            }
            .navigationTitle("Players")
        }
        .onAppear {
            vm.loadInitialData()
        }
        .searchable(text: $vm.name, placement: .navigationBarDrawer, prompt: "Search a player")
        .onChange(of: vm.name) {
            vm.search()
        }
        .onSubmit(of: .search) {
            vm.submitSearch()
        }
    }
}

#Preview {
        PlayersView()

}
