//
//  HomeViewModel.swift
//  Countertop
//
//  Created by Erik on 24/08/2026.
//

import Foundation

@MainActor
@Observable
final class HomeViewModel {
    private let router: Router

    init(router: Router) {
        self.router = router
    }

    // MARK: - Intents

    /// Navigation is a view-model decision: the view reports intent, the view
    /// model asks the router. Views never build destinations themselves.
    func showDetail(id: UUID) {
        router.push(.detail(id: id))
    }

    func showSettings() {
        router.present(.settings)
    }
}
