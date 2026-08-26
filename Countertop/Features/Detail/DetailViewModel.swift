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
    private(set) var recipe: RecipeListEntry?

    private let recipeRepository: any RecipeRepository
    private let router: Router

    init(id: UUID, recipeRepository: any RecipeRepository, router: Router) {
        self.id = id
        self.recipeRepository = recipeRepository
        self.router = router
    }

    // MARK: - Loading

    /// Resolves the id this screen was pushed with into a recipe.
    ///
    /// Leaves `recipe` nil when the record is gone, which the view renders as a
    /// missing state rather than treating as a failure.
    func load() async {
        recipe = try? await recipeRepository.recipe(id: id)
    }

    // MARK: - Intents

    func close() {
        router.pop()
    }
}
