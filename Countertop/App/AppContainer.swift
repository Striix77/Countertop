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
    let recipeRepository: any RecipeRepository

    init(recipeRepository: any RecipeRepository) {
        self.recipeRepository = recipeRepository
    }

    /// The wiring the shipping app uses.
    static func live() -> AppContainer {
        //TODO: Uncomment this after implementing recipe adding
//        AppContainer(recipeRepository: BundledRecipeRepository())
        AppContainer(recipeRepository: InMemoryRecipeRepository())
    }

    /// Same shape as `live()`, kept separate so previews and tests can diverge.
    static func preview() -> AppContainer {
        AppContainer(recipeRepository: InMemoryRecipeRepository())
    }

    // MARK: - View models

    func makeHomeViewModel(router: Router) -> HomeViewModel {
        HomeViewModel(recipeRepository: recipeRepository, router: router)
    }

    func makeDetailViewModel(id: UUID, router: Router) -> DetailViewModel {
        DetailViewModel(id: id, recipeRepository: recipeRepository, router: router)
    }

    func makeSettingsViewModel(router: Router) -> SettingsViewModel {
        SettingsViewModel(router: router)
    }
}
