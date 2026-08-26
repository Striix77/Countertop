import Foundation

struct RecipeListEntry: Identifiable, Codable, Hashable, Sendable {
    let id: UUID
    let title: String
    let imageURL: URL?
    let caloriesPerServing: Int?
    let servings: Int
}
