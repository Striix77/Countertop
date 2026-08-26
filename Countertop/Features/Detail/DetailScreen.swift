//
//  DetailScreen.swift
//  Countertop
//
//  Created by Erik on 24/08/2026.
//

import SwiftUI

struct DetailScreen: View {
    @State private var viewModel: DetailViewModel

    init(viewModel: DetailViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 16) {
            Text("Detail")
            Button("Close") { viewModel.close() }
        }
        .navigationTitle("Detail")
        .task { await viewModel.load() }
    }
}

#Preview {
    let container = AppContainer.preview()
    let router = Router()

    NavigationStack {
        DetailScreen(viewModel: container.makeDetailViewModel(id: UUID(), router: router))
    }
}
