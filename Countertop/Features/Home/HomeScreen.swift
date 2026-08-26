//
//  HomeScreen.swift
//  Countertop
//
//  Created by Erik on 24/08/2026.
//

import SwiftUI

struct HomeScreen: View {
    @State private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    private var gridColumns: [GridItem] {
        [.init(.adaptive(minimum: 160)), .init(.adaptive(minimum: 160))]
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 16) {
                ForEach(viewModel.recipes, id: \.id) { recipe in
                    VStack(spacing: 16) {
                        Text(recipe.title)
                        Button("Show Recipe") { viewModel.showDetail(id: recipe.id) }
                    }
                }
            }
        }
        .navigationTitle("Countertop")
        VStack(spacing: 16) {
            Text("Home")
            Button("Push Detail") { viewModel.showDetail(id: UUID()) }
            Button("Present Settings") { viewModel.showSettings() }
        }
        .task { await viewModel.load() }
    }
}

#Preview {
    let container = AppContainer.preview()
    let router = Router()

    NavigationStack {
        HomeScreen(viewModel: container.makeHomeViewModel(router: router))
    }
}
