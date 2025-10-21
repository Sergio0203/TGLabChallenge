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
            CustomTable(
                items: vm.playersList,
                columns: columns,
                onRowTapped: { player in
                    vm.selectedPlayer = player
                }
            )
            
            .onAppear {
                vm.loadInitialData()
            }
            .navigationTitle("Players")
            .navigationDestination(item: $vm.selectedPlayer) { player in
                GamesView(selectedId: player.team.id, teamName: player.team.name)
            }
        }
    }
}
#Preview {
    NavigationStack {
        PlayersView()
    }
}
