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

    var body: some View {
        VStack(spacing: 16) {
            Text("Home")
            Button("Push Detail") { viewModel.showDetail(id: UUID()) }
            Button("Present Settings") { viewModel.showSettings() }
        }
        .navigationTitle("Countertop")
    }
}

#Preview {
    let container = AppContainer.preview()
    let router = Router()

    NavigationStack {
        HomeScreen(viewModel: container.makeHomeViewModel(router: router))
    }
}
