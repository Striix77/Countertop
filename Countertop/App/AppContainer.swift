//
//  AppContainer.swift
//  Countertop
//
//  Created by Erik on 24/08/2026.
//

import Foundation

/// Holds the app's long-lived dependencies and builds view models from them.
///
/// Screens ask the container for a view model instead of constructing one, so
/// service wiring stays in a single place and tests can substitute fakes.
@MainActor
@Observable
final class AppContainer {
    // Register services here as they arrive, e.g.
    // let recipeRepository: any RecipeRepository

    init() { }

    /// The wiring the shipping app uses.
    static func live() -> AppContainer {
        AppContainer()
    }

    /// Same shape as `live()`, kept separate so previews and tests can diverge.
    static func preview() -> AppContainer {
        AppContainer()
    }

    // MARK: - View models

    func makeHomeViewModel(router: Router) -> HomeViewModel {
        HomeViewModel(router: router)
    }

    func makeDetailViewModel(id: UUID, router: Router) -> DetailViewModel {
        DetailViewModel(id: id, router: router)
    }

    func makeSettingsViewModel(router: Router) -> SettingsViewModel {
        SettingsViewModel(router: router)
    }
}
