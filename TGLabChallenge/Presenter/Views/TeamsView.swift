//
//  TeamsView.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//

import SwiftUI
import NBAService
struct TeamsView: View {
    @Environment(NBAViewModel.self) var vm
    @State private var selectedTeamID: Int?

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
                    selectedTeamID = team.id
                }
            )
            .navigationTitle("Teams")
            .navigationDestination(item: $selectedTeamID) { teamID in
                Text("Detail view for team ID: \(teamID)")
            }
            .onAppear() {
                vm.fetchTeams()
            }
        }
    }
}

#if DEBUG
#Preview {
    struct PreviewHelper: View {
        @State private var vm = NBAViewModel()

        var body: some View {
            TeamsView()
                .environment(vm)
                .onAppear {
                    vm.teamsList = [
                        .init(id: 1, name: "Los Angeles Lakers With a Very Long Name", conference: "West", city: "Los Angeles"),
                        .init(id: 2, name: "Boston Celtics", conference: "East", city: "Boston"),
                        .init(id: 3, name: "Philadelphia 76ers", conference: "East", city: "Philadelphia"),
                    ]
                }
        }
    }

    return PreviewHelper()
}
#endif
