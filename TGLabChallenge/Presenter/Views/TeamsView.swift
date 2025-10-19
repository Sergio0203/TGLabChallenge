//
//  TeamsView.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//

import SwiftUI

struct TeamsView: View {
    @State var vm = TeamsViewViewModel()
    var body: some View {
        Text("Teams View")
            .onAppear {
                vm.fetchTeams()
            }
    }
}

#Preview {
    TeamsView()
}
