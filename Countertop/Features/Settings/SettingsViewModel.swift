//
//  SettingsViewModel.swift
//  Countertop
//
//  Created by Erik on 24/08/2026.
//

import Foundation

@MainActor
@Observable
final class SettingsViewModel {
    private let router: Router

    init(router: Router) {
        self.router = router
    }

    // MARK: - Intents

    /// Dismissal goes through the router too, so the modal's lifetime is owned
    /// by the same place as the rest of the navigation state.
    func close() {
        router.dismissSheet()
    }
}
