//
//  TeamsView.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//

import SwiftUI

struct TeamsView: View {
    @Environment(NBAViewModel.self) var vm
    var body: some View {
        
    }
}

#if DEBUG
#Preview {
    TeamsView()
        .environment(NBAViewModel())
}
#endif
