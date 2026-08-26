import Foundation

/// A fixed set of recipes for previews and tests.
///
/// Kept in the app target so `AppContainer.preview()` can use it; it never
/// touches the filesystem, so previews can't fail on a missing resource.
struct InMemoryRecipeRepository: RecipeRepository {
    let recipes: [RecipeListEntry]

    init(recipes: [RecipeListEntry] = .samples) {
        self.recipes = recipes
    }

    func allRecipes() async throws -> [RecipeListEntry] {
        recipes
    }

    func recipe(id: UUID) async throws -> RecipeListEntry? {
        recipes.first { $0.id == id }
    }
}

extension [RecipeListEntry] {
    static var samples: [RecipeListEntry] {
        [
            RecipeListEntry(
                id: UUID(),
                title: "Lemon Ricotta Pancakes",
                imageURL: nil,
                caloriesPerServing: 320,
                servings: 4
            ),
            RecipeListEntry(
                id: UUID(),
                title: "Charred Broccoli with Tahini",
                imageURL: nil,
                caloriesPerServing: 180,
                servings: 2
            ),
            RecipeListEntry(
                id: UUID(),
                title: "Weeknight Chicken Ragù",
                imageURL: nil,
                caloriesPerServing: 540,
                servings: 6
            ),
        ]
    }
}
