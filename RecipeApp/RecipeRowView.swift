import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    let onToggle: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            if let image = UIImage(named: recipe.imageName) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            } else {
                Image(systemName: "photo")
                    .foregroundStyle(.secondary)
                    .frame(width: 44, height: 44)
                    .background(.quaternary)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(recipe.name)
                    .font(.headline)

                Text(recipe.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                onToggle()
            } label: {
                Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(recipe.isFavorite ? .red : .gray)
                    .padding(8)
            }
            .buttonStyle(.borderless)
            .accessibilityLabel(recipe.isFavorite ? "Remove from favorites" : "Add to favorites")
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    RecipeRowView(
        recipe: Recipe(
            name: "Spaghetti Carbonara",
            description: "Classic Italian pasta",
            ingredients: ["Pasta", "Eggs", "Bacon", "Cheese"],
            imageName: "spaghetti",
            isFavorite: true
        ),
        onToggle: {}
    )
    .padding()
}

