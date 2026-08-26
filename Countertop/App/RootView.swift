import SwiftUI

/// Hosts the navigation stack and binds it to the router the whole scene shares.
struct RootView: View {
    let container: AppContainer
    @State private var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            RouteView(route: .home, container: container, router: router)
                .navigationDestination(for: Route.self) { route in
                    RouteView(route: route, container: container, router: router)
                }
        }
        .sheet(item: $router.presentedSheet) { sheet in
            SheetRouteView(sheet: sheet, container: container, router: router)
        }
    }
}

#Preview {
    RootView(container: .preview())
}
