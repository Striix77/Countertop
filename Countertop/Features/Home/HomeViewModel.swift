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
    private(set) var recipes: [RecipeListEntry] = []
    private(set) var isLoading = false
    private(set) var loadFailed = false

    private let recipeRepository: any RecipeRepository
    private let router: Router
    private let favoritesStore: FavoritesStore

    var searchInput: String = ""

    var searchedRecipes: [RecipeListEntry] {
        if searchInput.isEmpty {
            return recipes
        }
        return recipes.filter { $0.matches(searchInput) }
    }

    init(recipeRepository: any RecipeRepository, favoritesStore: FavoritesStore, router: Router) {
        self.recipeRepository = recipeRepository
        self.router = router
        self.favoritesStore = favoritesStore
    }

    // MARK: - Loading

    /// Fetches the list the home screen shows.
    ///
    /// Guards on `isLoading` because `.task` re-runs when the view's identity
    /// changes, and a second in-flight load would just overwrite the first.
    func load() async {
        guard !isLoading else { return }

        isLoading = true
        loadFailed = false

        do {
            recipes = try await recipeRepository.allRecipes()
        } catch {
            loadFailed = true
        }

        isLoading = false
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

    // MARK: - Favorites

    func toggleFavorite(id: UUID) {
        favoritesStore.toggle(id)
    }

    func isFavorite(id: UUID) -> Bool {
        favoritesStore.contains(id)
    }
}
