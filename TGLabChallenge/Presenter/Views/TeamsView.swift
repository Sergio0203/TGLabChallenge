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
    var body: some View {
        NavigationStack {
            ScrollView {
                Grid(alignment: .leading) {
                    GridRow {
                        Text("Name")
                        Text("City")
                        Text("Conference")
                    }
                    .bold()

                    Divider()

                    ForEach(vm.teamsList) { team in
                        GridRow(alignment: .center){
                            Text(team.fullName)
                            Text(team.city)
                            Text(team.conference)
                            Image(systemName: "chevron.right")
                        }
                        Divider()
                    }
                }
                .padding()
            }
            .padding(.horizontal, 8)
            .navigationTitle("Teams")
            .onAppear() {
                vm.fetchTeams()
            }
        }
    }
}

#if DEBUG
#Preview {
    @State var vm: NBAViewModel = .init()
    TeamsView()
        .environment(vm)
}
#endif
