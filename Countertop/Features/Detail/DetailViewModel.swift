//
//  DetailViewModel.swift
//  Countertop
//
//  Created by Erik on 24/08/2026.
//

import Foundation

@MainActor
@Observable
final class DetailViewModel {
    let id: UUID
    private let router: Router

    init(id: UUID, router: Router) {
        self.id = id
        self.router = router
    }

    // MARK: - Intents

    func close() {
        router.pop()
    }
}
