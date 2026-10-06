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
    let favoritesStore: FavoritesStore

    init(recipeRepository: any RecipeRepository, favoritesStore: FavoritesStore) {
        self.recipeRepository = recipeRepository
        self.favoritesStore = favoritesStore
    }

    /// The wiring the shipping app uses.
    static func live() -> AppContainer {
        // TODO: Uncomment this after implementing recipe adding
//        AppContainer(recipeRepository: BundledRecipeRepository())
        AppContainer(recipeRepository: InMemoryRecipeRepository(), favoritesStore: FavoritesStore())
    }

    /// Same shape as `live()`, kept separate so previews and tests can diverge.
    static func preview() -> AppContainer {
        AppContainer(recipeRepository: InMemoryRecipeRepository(), favoritesStore: FavoritesStore())
    }

    // MARK: - View models

    func makeHomeViewModel(router: Router) -> HomeViewModel {
        HomeViewModel(recipeRepository: recipeRepository, favoritesStore: favoritesStore, router: router)
    }

    func makeDetailViewModel(id: UUID, router: Router) -> DetailViewModel {
        DetailViewModel(id: id, recipeRepository: recipeRepository, router: router)
    }

    func makeSettingsViewModel(router: Router) -> SettingsViewModel {
        SettingsViewModel(router: router)
    }
}
