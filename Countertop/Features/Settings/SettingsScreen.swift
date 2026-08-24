//
//  SettingsScreen.swift
//  Countertop
//
//  Created by Erik on 24/08/2026.
//

import SwiftUI

struct SettingsScreen: View {
    @State private var viewModel: SettingsViewModel

    init(viewModel: SettingsViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            Text("Settings")
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Done") { viewModel.close() }
                    }
                }
        }
    }
}

#Preview {
    let container = AppContainer.preview()
    let router = Router()

    SettingsScreen(viewModel: container.makeSettingsViewModel(router: router))
}
