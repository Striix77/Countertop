import Foundation

/// The single source of truth for which recipes the user favorited.
///
/// Holds identifiers rather than recipes so a favorite can't drift out of sync
/// with the recipe it points at, and so favorites survive a recipe cache that
/// gets cleared or refetched.
@MainActor
@Observable
final class FavoritesStore {
    private(set) var favoritedIDs: Set<UUID> = []

    func contains(_ id: UUID) -> Bool {
        favoritedIDs.contains(id)
    }

    func toggle(_ id: UUID) {
        if favoritedIDs.contains(id) {
            favoritedIDs.remove(id)
        } else {
            favoritedIDs.insert(id)
        }
        // Persist here once storage is picked (UserDefaults is fine at this size).
    }
}
