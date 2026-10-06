import Foundation

extension RecipeListEntry {
    func matches(_ query: String) -> Bool {
        title.localizedCaseInsensitiveContains(query.lowercased())
    }
}
