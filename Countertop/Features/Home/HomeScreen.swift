import SwiftUI

struct HomeScreen: View {
    @State private var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    private var gridColumns: [GridItem] {
        [.init(.adaptive(minimum: 160))]
    }

    private var recipeCount: Int {
        viewModel.recipes.count
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: Organic.Space.s4) {
                    header

                    searchField

                    recipeGrid
                }
            }
        }
        .padding(Organic.Space.s4)
        .task { await viewModel.load() }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Countertop")
                    .font(Organic.Font.h1)
                Text("\(recipeCount) recipes on the shelf")
                    .font(Organic.Font.subHeading)
                    .foregroundStyle(Organic.Color.muted)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(
                "",
                text: $viewModel.searchInput,
                prompt: Text("Search for recipes or ingredients")
                    .foregroundStyle(Organic.Color.muted)
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Organic.Color.surface)
        .clipShape(Capsule())
        .foregroundStyle(Organic.Color.text)
        .font(Organic.Font.body)
    }

    private var recipeGrid: some View {
        LazyVGrid(columns: gridColumns, spacing: Organic.Space.s4) {
            ForEach(viewModel.searchedRecipes, id: \.id) { recipe in
                recipeItemButton(recipe: recipe)
            }
        }
    }

    private func recipeItemButton(recipe: RecipeListEntry) -> some View {
        Button {
            viewModel.showDetail(id: recipe.id)
        }
        label: {
            VStack {
                recipeItemCard(id: recipe.id)

                recipeItemDetails(recipe: recipe)
            }
        }
        .buttonStyle(.plain)
    }

    private func recipeItemCard(id: UUID) -> some View {
        ZStack(alignment: .topTrailing) {
            OrganicStripePattern()
                .frame(maxWidth: .infinity)
                .aspectRatio(1.3, contentMode: .fit)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: Organic.Radius.lg,
                        style: .continuous
                    )
                )

            Button {
                viewModel.toggleFavorite(id: id)
            } label: {
                Image(systemName: viewModel.isFavorite(id: id) ? "heart.fill" : "heart")
                    .resizable()
                    .aspectRatio(1.1, contentMode: .fit)
                    .foregroundStyle(viewModel.isFavorite(id: id) ? Organic.Color.accent : Organic.Color.muted)
                    .frame(width: 16)
                    .padding(Organic.Space.s2)
                    .background(Organic.Color.bg)
                    .clipShape(Circle())
                    .padding(Organic.Space.s2)
            }
            .buttonStyle(.plain)
        }
    }

    private func recipeItemDetails(recipe: RecipeListEntry) -> some View {
        VStack(
            alignment: .leading,
            spacing: Organic.Space.s1
        ) {
            Text(recipe.title)
                .font(Organic.Font.h5)
                .multilineTextAlignment(.leading)

            HStack {
                if let caloriesPerServing = recipe
                    .caloriesPerServing
                {
                    Text("\(caloriesPerServing) kcal")
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(
                            1,
                            contentMode: .fit
                        )
                        .frame(width: 4)
                }

                Text("\(recipe.servings) servings")
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
            .font(Organic.Font.bodySmall)
            .foregroundStyle(Organic.Color.muted)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, Organic.Space.s1)
    }
}

#Preview {
    let container = AppContainer.preview()
    let router = Router()

    NavigationStack {
        HomeScreen(viewModel: container.makeHomeViewModel(router: router))
            .organicScreen()
    }
}
