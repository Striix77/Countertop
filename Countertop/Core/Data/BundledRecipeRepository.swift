import Foundation

/// Serves recipes from a JSON file shipped in the app bundle.
///
/// The decode runs off the main actor and the result is cached, so the home
/// screen pays for it once per launch instead of once per appearance.
actor BundledRecipeRepository: RecipeRepository {
    private let resourceName: String
    private let bundle: Bundle
    private var cached: [RecipeListEntry]?

    init(resourceName: String = "recipes", bundle: Bundle = .main) {
        self.resourceName = resourceName
        self.bundle = bundle
    }

    func allRecipes() async throws -> [RecipeListEntry] {
        if let cached { return cached }

        guard let url = bundle.url(forResource: resourceName, withExtension: "json") else {
            throw RecipeRepositoryError.sourceUnavailable("\(resourceName).json")
        }

        let data = try Data(contentsOf: url)
        let recipes = try JSONDecoder().decode([RecipeListEntry].self, from: data)
        cached = recipes
        return recipes
    }

    func recipe(id: UUID) async throws -> RecipeListEntry? {
        try await allRecipes().first { $0.id == id }
    }
}
