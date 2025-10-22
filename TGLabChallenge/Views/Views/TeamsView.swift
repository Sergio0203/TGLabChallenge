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
        .init(maxWidth: 100, title: { TableCell("Name") }) { team in
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
            if vm.teamsList.isEmpty {
                ProgressView()
                    .onAppear() {
                        vm.loadInitialData()
                    }
            } else {
                CustomTable(
                    items: vm.teamsList,
                    columns: columns,
                    onRowTapped: { team in
                        vm.selectedTeam = team
                    }
                )
                .navigationTitle("Home")
                .navigationDestination(item: $vm.selectedTeam) { team in
                    GamesView(selectedId: team.id, teamName: team.name)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            vm.showSheet = true
                        }) {
                            Text(vm.sortingCriteria.rawValue)
                                .tint(.accentColor)
                        }
                    }
                }
                .sheet(isPresented: $vm.showSheet) {
                    List {
                        ForEach(SortingCriteria.allCases, id: \.rawValue) { sortingCriteria in
                            Button(action: {
                                vm.sortingCriteria = sortingCriteria
                                vm.showSheet = false
                            }, label: {
                                Text(sortingCriteria.rawValue)
                            })
                        }
                    }
                }
                .onChange(of: vm.sortingCriteria) {
                    vm.sortTeamList()
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    TeamsView()
}
#endif
