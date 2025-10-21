//
//  CustomList.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//
import SwiftUI

struct CustomTable<Element: Identifiable>: View {
    let items: [Element]
    let columns: [CustomTableColumn<Element>]
    let onRowTapped: ((Element) -> Void)?

    init(
        items: [Element],
        columns: [CustomTableColumn<Element>],
        onRowTapped: ((Element) -> Void)? = nil,
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
                    GridRow(alignment: .top) {
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
