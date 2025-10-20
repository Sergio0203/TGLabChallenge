//
//  CustomList.swift
//  TGLabChallenge
//
//  Created by Sérgio César Lira Júnior on 19/10/25.
//
import SwiftUI

struct CustomTable<Element: Identifiable, HeaderContent: View, RowContent: View>: View {
    let items: [Element]
    let onRowTapped: ((Element) -> Void)?
    @ViewBuilder let headerContent: () -> HeaderContent
    @ViewBuilder let rowContent: (Element) -> RowContent

    init(items: [Element], onRowTapped: ((Element) -> Void)? = nil, @ViewBuilder headerContent: @escaping () -> HeaderContent, @ViewBuilder rowContent: @escaping (Element) -> RowContent) {
        self.items = items
        self.onRowTapped = onRowTapped
        self.headerContent = headerContent
        self.rowContent = rowContent
    }

    var body: some View {
        ScrollView {
            Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 12) {
                GridRow {
                    headerContent()
                    if onRowTapped != nil {
                        Spacer()
                        Image(systemName: "chevron.right")
                            .hidden()
                    }
                }
                .font(.headline)
                Divider()
                ForEach(items) { item in
                    GridRow(alignment: .center) {
                        rowContent(item)
                        if onRowTapped != nil {
                            Spacer()
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
        }
    }
}

private struct SampleData: Identifiable, Codable {
    let id: UUID
    let name: String
    let status: String
    let description: String
}

#Preview {
    struct PreviewContainer: View {
        @State private var sampleItems: [SampleData] = [
            .init(id: UUID(), name: "Item 1", status: "Ativo", description: "Descrição mais longa para o primeiro item."),
            .init(id: UUID(), name: "Item Com Nome Bem Longo", status: "Pendente", description: "Segunda descrição."),
            .init(id: UUID(), name: "Outro Item", status: "Concluído", description: "A terceira e última descrição para este exemplo.")
        ]
        
        var body: some View {
            VStack(spacing: 30) {
                Text("Tabela Clicável")
                    .font(.title2.bold())
                
                // Exemplo com linhas clicáveis
                CustomTable(
                    items: sampleItems,
                    onRowTapped: { item in
                        print("Item tocado: \(item.name)")
                    }
                ) {
                    Text("Nome")
                    Text("Status")
                    Text("Descrição")
                } rowContent: { item in
                    Text(item.name)
                    Text(item.status)
                    Text(item.description)
                }
                
                Text("Tabela Não Clicável")
                    .font(.title2.bold())
                
                // Exemplo com o padrão (linhas não clicáveis)
                CustomTable(items: sampleItems) {
                    Text("Nome")
                    Text("Status")
                    Text("Descrição")
                } rowContent: { item in
                    Text(item.name)
                    Text(item.status)
                    Text(item.description)
                }
            }
        }
    }
    
    return PreviewContainer()
}
