import Foundation

/// Reads recipes for the app, hiding where they actually come from.
///
/// View models depend on this protocol rather than a concrete store, so the
/// backing source (bundled JSON today, network or SwiftData later) can change
/// without touching a feature, and tests can hand over a fake.
///
/// `Sendable` and non-isolated: the container holds it on the main actor but the
/// work happens off it, so callers `await` and stay responsive.
protocol RecipeRepository: Sendable {
    /// Every recipe available for the home list.
    func allRecipes() async throws -> [RecipeListEntry]

    /// A single recipe by identifier, or `nil` if it no longer exists.
    ///
    /// Detail screens carry an id rather than a model, so they need this to
    /// resolve one after the list that produced it has gone away.
    func recipe(id: UUID) async throws -> RecipeListEntry?
}

enum RecipeRepositoryError: Error {
    /// The bundled seed file is missing or was renamed.
    case sourceUnavailable(String)
}
