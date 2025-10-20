//
//  CustomList.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//
import SwiftUI

// Struct para definir as colunas da tabela de forma explícita.
struct CustomTableColumn<Element> {
    let title: AnyView
    let content: (Element) -> AnyView
    let maxWidth: CGFloat? // Nova propriedade para a largura máxima

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

struct CustomTable<Element: Identifiable>: View {
    let items: [Element]
    let columns: [CustomTableColumn<Element>]
    let onRowTapped: ((Element) -> Void)?

    init(
        items: [Element],
        columns: [CustomTableColumn<Element>],
        onRowTapped: ((Element) -> Void)? = nil
    ) {
        self.items = items
        self.columns = columns
        self.onRowTapped = onRowTapped
    }

    var body: some View {
        ScrollView {
            let gridContent = Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 12) {
                GridRow {
                    ForEach(0..<columns.count, id: \.self) { index in
                        let column = columns[index]
                        column.title
                            .frame(maxWidth: column.maxWidth, alignment: .center)
                    }
                }
                .font(.headline)
                Divider()
                ForEach(items) { item in
                    GridRow(alignment: .top) { // Alterado de .center para .top
                        ForEach(0..<columns.count, id: \.self) { index in
                            let column = columns[index]
                            column.content(item)
                                .frame(maxWidth: column.maxWidth, alignment: .center)
                        }
                        
                        if onRowTapped != nil {
                            Image(systemName: "chevron.right")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        onRowTapped?(item)
                    }
                    Divider()
                }
            }
            .padding()
            ViewThatFits(in: .horizontal) {
                gridContent
                ScrollView(.horizontal, showsIndicators: true) {
                    gridContent
                }
            }
        }
    }
}
