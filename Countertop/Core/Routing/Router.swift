//
//  Router.swift
//  Countertop
//
//  Created by Erik on 24/08/2026.
//

import Foundation

/// Owns all navigation state for a scene.
///
/// View models talk to the router; views never construct destinations
/// themselves. That keeps navigation decisions testable and lets any screen
/// route to any other without knowing which view is on screen.
@MainActor
@Observable
final class Router {
    var path: [Route] = []
    var presentedSheet: SheetRoute?

    // MARK: - Stack

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }

    // MARK: - Modals

    func present(_ sheet: SheetRoute) {
        presentedSheet = sheet
    }

    func dismissSheet() {
        presentedSheet = nil
    }
}
