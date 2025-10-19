//
//  ContentView.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 17/10/25.
//

import SwiftUI
import NBAService
struct ContentView: View {
    @State private var vm = NBAViewModel()
    var body: some View {
        TabView {
            TeamsView()
                .environment(vm)
                .tabItem {
                    Label("Times", systemImage: "list.bullet")
                }
            Text("Text")
                .tabItem {
                    Label("Jogos", systemImage: "gamecontroller")
                }

        }
    }
}

#Preview {
    ContentView()
}
