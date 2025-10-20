//
//  TableCell.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//

import SwiftUI

struct TableCell<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
    }
}

extension TableCell where Content == Text {
    init(_ text: String) {
        self.init {
            Text(text)
        }
    }
}
