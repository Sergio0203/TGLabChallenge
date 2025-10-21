//
//  TeamsView.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//

import SwiftUI
struct TeamsView: View {
    @State var vm = TeamsViewModel()
    private let columns: [CustomTableColumn<TeamModel>] = [
        .init(maxWidth: 110, title: { TableCell("Name") }) { team in
            TableCell(team.name)
        },
        .init(maxWidth: 100, title: { TableCell("City") }) { team in
            TableCell(team.city)
        },
        .init(maxWidth: 100, title: { TableCell("Conference") }) { team in
            TableCell(team.conference)
        },
    ]

    var body: some View {
        NavigationStack {
            CustomTable(
                items: vm.teamsList,
                columns: columns,
                onRowTapped: { team in
                    print(team.id)
                    vm.selectedTeam = team
                }
            )
            .navigationTitle("Home")
            .navigationDestination(item: $vm.selectedTeam) { team in
                GamesView(selectedId: team.id, teamName: team.name)
            }
            .onAppear() {
                vm.loadInitialData()
            }
        }
    }
}

#if DEBUG
#Preview {
    TeamsView()
}
#endif
