//
//  CountertopApp.swift
//  Countertop
//
//  Created by Erik on 24/08/2026.
//

import SwiftUI

@main
struct CountertopApp: App {
    @State private var container = AppContainer.live()

    var body: some Scene {
        WindowGroup {
            RootView(container: container)
        }
    }
}
