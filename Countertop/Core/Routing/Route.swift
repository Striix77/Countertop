//
//  Route.swift
//  Countertop
//
//  Created by Erik on 24/08/2026.
//

import Foundation

/// A destination pushed onto the navigation stack.
///
/// Cases carry identifiers rather than whole models, so a pushed screen stays
/// valid after the record behind it is edited or reloaded elsewhere.
nonisolated enum Route: Hashable, Sendable {
    case home
    case detail(id: UUID)
}

/// A destination presented modally.
nonisolated enum SheetRoute: Identifiable, Hashable, Sendable {
    case settings

    var id: String {
        switch self {
        case .settings: "settings"
        }
    }
}
