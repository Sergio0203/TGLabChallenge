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

    var body: some View {
        NavigationStack {
            CustomTable(items: vm.teamsList) {
                Text("Name")
                Text("City")
                Text("Conference")
            } rowContent: { team in
                Text(team.name)
                Text(team.city)
                Text(team.conference)
            }
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
