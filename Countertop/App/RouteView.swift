//
//  RouteView.swift
//  Countertop
//
//  Created by Erik on 24/08/2026.
//

import SwiftUI

/// The single place a `Route` turns into a screen.
///
/// Keeping the mapping here means a feature can route to another feature
/// without importing it — it pushes a `Route` and this view resolves it.
struct RouteView: View {
    let route: Route
    let container: AppContainer
    let router: Router

    var body: some View {
        Group {
            switch route {
            case .home:
                HomeScreen(viewModel: container.makeHomeViewModel(router: router))
            case .detail(let id):
                DetailScreen(viewModel: container.makeDetailViewModel(id: id, router: router))
            }
        }
        .organicScreen()
    }
}

/// The same mapping for modal destinations.
struct SheetRouteView: View {
    let sheet: SheetRoute
    let container: AppContainer
    let router: Router

    var body: some View {
        Group {
            switch sheet {
            case .settings:
                SettingsScreen(viewModel: container.makeSettingsViewModel(router: router))
            }
        }
        .organicScreen()
    }
}
