import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe
    let onToggle: () -> Void

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let image = UIImage(named: recipe.imageName) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                } else {
                    Image(systemName: "photo")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 220)
                        .background(.quaternary)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                Text(recipe.name)
                    .font(.largeTitle.bold())

                HStack(spacing: 8) {
                    Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(recipe.isFavorite ? .red : .gray)

                    Text(recipe.isFavorite ? "Favorite recipe" : "Not a favorite")
                        .font(.headline)
                        .foregroundStyle(.secondary)
                }

                Text(recipe.description)
                    .font(.body)

                VStack(alignment: .leading, spacing: 12) {
                    Text("Ingredients")
                        .font(.title2.bold())

                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        HStack(alignment: .firstTextBaseline, spacing: 10) {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 6))
                                .foregroundStyle(.tint)

                            Text(ingredient)
                        }
                    }
                }

                Button {
                    onToggle()
                } label: {
                    Label(
                        recipe.isFavorite ? "Remove from Favorites" : "Add to Favorites",
                        systemImage: recipe.isFavorite ? "heart.slash" : "heart"
                    )
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(
            recipe: Recipe(
                name: "Miso Ramen",
                description: "Savory noodle soup",
                ingredients: ["Noodles", "Miso", "Broth", "Egg"],
                imageName: "ramen",
                isFavorite: false
            ),
            onToggle: {}
        )
    }
}

