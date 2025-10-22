//
//  ContentView.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 17/10/25.
//

import SwiftUI
import NBAService
struct ContentView: View {
    var body: some View {
        TabView {
            TeamsView()
                .tabItem {
                    Label("Home", systemImage: "list.bullet")
                }
            PlayersView()
                .tabItem {
                    Label("Players", systemImage: "person")                   }
        }
    }
}

#Preview {
    ContentView()
}

