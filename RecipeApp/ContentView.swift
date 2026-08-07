import SwiftUI

struct Recipe: Identifiable {
    let id = UUID()
    let name: String
    let description: String
    let ingredients: [String]
    let imageName: String
    var isFavorite: Bool
}

struct ContentView: View {
    @State private var searchText = ""

    @State private var recipes: [Recipe] = [
        Recipe(
            name: "Spaghetti Carbonara",
            description: "Classic Italian pasta",
            ingredients: ["Pasta", "Eggs", "Bacon", "Cheese"],
            imageName: "spaghetti",
            isFavorite: true
        ),
        Recipe(
            name: "Greek Salad",
            description: "Fresh Mediterranean",
            ingredients: ["Tomato", "Cucumber", "Feta", "Olives"],
            imageName: "salad",
            isFavorite: false
        ),
        Recipe(
            name: "Chicken Tikka Masala",
            description: "Creamy Indian curry",
            ingredients: ["Chicken", "Spices", "Cream", "Tomato"],
            imageName: "chicken",
            isFavorite: true
        ),
        Recipe(
            name: "Blueberry Pancakes",
            description: "Fluffy breakfast",
            ingredients: ["Flour", "Milk", "Eggs", "Blueberries"],
            imageName: "pancakes",
            isFavorite: false
        ),
        Recipe(
            name: "Miso Ramen",
            description: "Savory noodle soup",
            ingredients: ["Noodles", "Miso", "Broth", "Egg"],
            imageName: "ramen",
            isFavorite: false
        ),
        Recipe(
            name: "Avocado Toast",
            description: "Simple brunch",
            ingredients: ["Bread", "Avocado", "Salt", "Lemon"],
            imageName: "toast",
            isFavorite: true
        )
    ]

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredRecipes) { recipe in
                    NavigationLink {
                        RecipeDetailView(
                            recipe: recipe,
                            onToggle: {
                                toggleFavorite(recipe)
                            }
                        )
                    } label: {
                        RecipeRowView(
                            recipe: recipe,
                            onToggle: {
                                toggleFavorite(recipe)
                            }
                        )
                    }
                }
            }
            .navigationTitle("My Recipes")
            .searchable(text: $searchText)
        }
    }

    private func toggleFavorite(_ recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index].isFavorite.toggle()
        }
    }
}

#Preview {
    ContentView()
}

