//
//  CustomTableColumn.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 20/10/25.
//
import SwiftUI
struct CustomTableColumn<Element> {
    let title: AnyView
    let content: (Element) -> AnyView
    let maxWidth: CGFloat?

    init<Title: View, Content: View>(
        maxWidth: CGFloat,
        @ViewBuilder title: () -> Title,
        @ViewBuilder content: @escaping (Element) -> Content
    ) {
        self.maxWidth = maxWidth
        self.title = AnyView(title())
        self.content = { AnyView(content($0)) }
    }

    init<Title: View, Content: View>(
        @ViewBuilder title: () -> Title,
        @ViewBuilder content: @escaping (Element) -> Content
    ) {
        self.maxWidth = nil
        self.title = AnyView(title())
        self.content = { AnyView(content($0)) }
    }
}
