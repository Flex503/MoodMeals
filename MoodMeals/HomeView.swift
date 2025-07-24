import SwiftUI
import UIKit

struct Mood: Identifiable {
    let id = UUID()
    let name: String
    let emoji: String
    let description: String
    let color: Color
    let imageName: String // New property for food image
}

struct FoodSuggestion: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let description: String
    let mood: String
}

let foodSuggestions: [FoodSuggestion] = [
    // Happy mood (3)
    FoodSuggestion(name: "Avocado Toast", imageName: "avocadotoast1", description: "A cheerful, vibrant breakfast with mashed avocado, cherry tomatoes, and chili flakes on whole grain bread.", mood: "Happy"),
    FoodSuggestion(name: "Fruit Parfait", imageName: "fruitparfait1", description: "Layers of Greek yogurt, fresh berries, granola, and a drizzle of honey.", mood: "Happy"),
    FoodSuggestion(name: "Rainbow Salad", imageName: "rainbowsalad1", description: "Mixed greens, cherry tomatoes, carrots, cabbage, sweet corn, and citrus vinaigrette.", mood: "Happy"),
    // Sad mood (3)
    FoodSuggestion(name: "Chocolate Cake", imageName: "chocalatecake1", description: "Comfort food for a blue mood.", mood: "Sad"),
    FoodSuggestion(name: "Mac & Cheese", imageName: "macandcheese1", description: "Classic creamy mac and cheese for cozy comfort.", mood: "Sad"),
    FoodSuggestion(name: "Tomato Soup", imageName: "tomatasoup1", description: "Warm tomato soup to lift your spirits.", mood: "Sad"),
    // Tired mood (3)
    FoodSuggestion(name: "Energy Smoothie", imageName: "energysmoothie1", description: "Boost your energy with fruits!", mood: "Tired"),
    FoodSuggestion(name: "Overnight Oats", imageName: "Overnightoats1", description: "Oats soaked with milk, chia seeds, and berries for a quick energy boost.", mood: "Tired"),
    FoodSuggestion(name: "Egg Muffins", imageName: "eggmuffins1", description: "Mini baked egg muffins with veggies and cheese.", mood: "Tired"),
    // Stressed mood (3)
    FoodSuggestion(name: "Chamomile Tea", imageName: "chamomiletea", description: "Relax and unwind.", mood: "Stressed"),
    FoodSuggestion(name: "Salmon & Rice Bowl", imageName: "salmonandricebowl", description: "Omega-3 rich salmon with brown rice and greens.", mood: "Stressed"),
    FoodSuggestion(name: "Banana Almond Smoothie", imageName: "Bananaalmondsmoothie", description: "Banana, almond butter, and milk blended for calm.", mood: "Stressed"),
    // Excited mood (3)
    FoodSuggestion(name: "Sushi Rolls", imageName: "Sushirolls", description: "Fun and flavorful!", mood: "Excited"),
    FoodSuggestion(name: "Taco Platter", imageName: "Tacoplatter", description: "Colorful tacos with assorted fillings.", mood: "Excited"),
    FoodSuggestion(name: "Bubble Tea", imageName: "BubbleTea", description: "Sweet and playful bubble tea treat.", mood: "Excited"),
    // Calm mood (3)
    FoodSuggestion(name: "Pasta Bowl", imageName: "pastabowl1", description: "A soothing bowl of pasta to help you unwind.", mood: "Calm"),
    FoodSuggestion(name: "Herbal Tea", imageName: "herbaltea1", description: "A warm cup of herbal tea for peace.", mood: "Calm"),
    FoodSuggestion(name: "Cucumber Sandwiches", imageName: "csandwich", description: "Light cucumber sandwiches for a relaxing snack.", mood: "Calm")
]

struct HomeView: View {
    @State private var selectedMood: Mood?
    @State private var showingMealSuggestions = false
    
    let moods: [Mood] = [
        Mood(name: "Happy", emoji: "😊", description: "Feeling joyful and energetic", color: .yellow, imageName: "food_happy"),
        Mood(name: "Sad", emoji: "😢", description: "Feeling down and need comfort", color: .blue, imageName: "food_sad"),
        Mood(name: "Tired", emoji: "😴", description: "Exhausted and need energy", color: .purple, imageName: "food_tired"),
        Mood(name: "Stressed", emoji: "😰", description: "Anxious and need calming", color: .orange, imageName: "food_stressed"),
        Mood(name: "Excited", emoji: "🤩", description: "Full of energy and enthusiasm", color: .pink, imageName: "food_excited"),
        Mood(name: "Calm", emoji: "🧘‍♂️", description: "Seeking peace and relaxation", color: .green, imageName: "food_calm")
    ]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                LinearGradient(
                    gradient: Gradient(colors: [Color.yellow.opacity(0.35), Color.clear]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea(edges: .top)
                ScrollView {
                    VStack(spacing: 18) {
                        // Header
                        VStack(spacing: 8) {
                            HStack(spacing: 12) {
                                Image(systemName: "fork.knife")
                                    .font(.system(size: 28, weight: .semibold))
                                    .foregroundColor(.orange)
                                Text("MoodMeals")
                                    .font(.system(size: 30, weight: .heavy, design: .rounded))
                                    .foregroundColor(.primary)
                            }
                            VStack(spacing: 0) {
                                Text("How are you feeling today?")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.primary)
                                    .multilineTextAlignment(.center)
                                    .padding(.bottom, 2)
                                Text("Tap a mood below and let us inspire your next meal!")
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .padding(12)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color(UIColor.systemGray6), Color(UIColor.systemGray5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            )
                            .cornerRadius(14)
                            .shadow(color: Color.orange.opacity(0.08), radius: 8, x: 0, y: 4)
                            .padding(.horizontal, 16)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 18)
                        .padding(.bottom, 6)
                        .background(Color.clear)
                        // Inspiration Card
                        TodaysInspirationCard()
                            .padding(.top, 2)
                            .padding(.bottom, 2)
                        // Mood Grid
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 14),
                            GridItem(.flexible(), spacing: 14)
                        ], spacing: 14) {
                            ForEach(moods) { mood in
                                MoodCard(mood: mood, isSelected: selectedMood?.id == mood.id) {
                                    let generator = UIImpactFeedbackGenerator(style: .medium)
                                    generator.impactOccurred()
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.7)) {
                                        selectedMood = mood
                                        showingMealSuggestions = true
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 14)
                        // Food Suggestions Section
                        if let mood = selectedMood {
                            let suggestions = foodSuggestions.filter { $0.mood == mood.name }
                            if !suggestions.isEmpty {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Suggestions for \(mood.name)")
                                        .font(.headline)
                                        .padding(.leading, 18)
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: 16) {
                                            ForEach(suggestions) { suggestion in
                                                VStack(alignment: .leading, spacing: 6) {
                                                    if let uiImage = UIImage(named: suggestion.imageName) {
                                                        Image(uiImage: uiImage)
                                                            .resizable()
                                                            .scaledToFill()
                                                            .frame(width: 90, height: 90)
                                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                                    } else {
                                                        Rectangle()
                                                            .fill(Color(.systemGray5))
                                                            .frame(width: 90, height: 90)
                                                            .clipShape(RoundedRectangle(cornerRadius: 16))
                                                    }
                                                    Text(suggestion.name)
                                                        .font(.system(size: 15, weight: .semibold))
                                                        .foregroundColor(.primary)
                                                    Text(suggestion.description)
                                                        .font(.system(size: 12))
                                                        .foregroundColor(.secondary)
                                                        .lineLimit(2)
                                                }
                                                .frame(width: 110)
                                                .padding(8)
                                                .background(Color.white)
                                                .cornerRadius(16)
                                                .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
                                                .onTapGesture {
                                                    let generator = UIImpactFeedbackGenerator(style: .soft)
                                                    generator.impactOccurred()
                                                }
                                            }
                                        }
                                        .padding(.horizontal, 12)
                                    }
                                }
                                .padding(.bottom, 2)
                            }
                        }
                        // CTA Button
                        if selectedMood != nil {
                            Button(action: {
                                let generator = UIImpactFeedbackGenerator(style: .light)
                                generator.impactOccurred()
                                showingMealSuggestions = true
                            }) {
                                HStack(spacing: 8) {
                                    Text("Get Meal Suggestions")
                                        .font(.system(size: 17, weight: .semibold))
                                    Image(systemName: "arrow.right")
                                        .font(.system(size: 15, weight: .semibold))
                                }
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 48)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [selectedMood?.color ?? .blue, selectedMood?.color.opacity(0.8) ?? .blue]),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(24)
                                .shadow(color: (selectedMood?.color ?? .blue).opacity(0.18), radius: 8, x: 0, y: 4)
                                .scaleEffect(1.03)
                            }
                            .padding(.horizontal, 32)
                            .padding(.top, 6)
                            .transition(.scale.combined(with: .opacity))
                        }
                        Spacer(minLength: 40)
                    }
                    .padding(.bottom, 8)
                }
                .background(Color(.systemGroupedBackground))
                .sheet(isPresented: $showingMealSuggestions) {
                    if let mood = selectedMood {
                        MealSuggestionView(mood: mood)
                    }
                }
            }
        }
    }
}

struct MoodCard: View {
    let mood: Mood
    let isSelected: Bool
    let action: () -> Void
    
    @State private var isPressed = false
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.2)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                isPressed = false
                action()
            }
        }) {
            VStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(mood.color.opacity(isSelected ? 0.25 : 0.15))
                        .frame(width: 80, height: 80)
                        .shadow(color: mood.color.opacity(isSelected ? 0.20 : 0.08), radius: isSelected ? 15 : 8, x: 0, y: 6)
                    // Food image or emoji
                    if let uiImage = UIImage(named: mood.imageName) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                    } else {
                        Text(mood.emoji)
                            .font(.system(size: 40))
                            .scaleEffect(isSelected || isPressed ? 1.15 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isSelected || isPressed)
                    }
                }
                VStack(spacing: 6) {
                    Text(mood.name)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.primary)
                    Text(mood.description)
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                }
            }
            .frame(height: 160)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .shadow(color: isSelected || isPressed ? mood.color.opacity(0.18) : Color.black.opacity(0.08), radius: isSelected || isPressed ? 16 : 8, x: 0, y: isSelected || isPressed ? 12 : 4)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? mood.color : Color.clear, lineWidth: 2.5)
            )
            .scaleEffect(isSelected || isPressed ? 1.08 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isSelected || isPressed)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct TodaysInspirationCard: View {
    let inspirations: [(String, String)] = [
        ("Try a new breakfast bowl!", "Start your day with a colorful fruit and yogurt bowl for energy and happiness."),
        ("Comfort in a bowl", "Warm soup can lift your spirits on a rainy day."),
        ("Go green today!", "A fresh salad with avocado and seeds is both healthy and delicious."),
        ("Sweet treat inspiration", "Bake some banana bread and share it with a friend!"),
        ("Hydrate & glow", "Infuse your water with lemon and mint for a refreshing boost."),
        ("Community pick", "Try a trending recipe from the MoodMeals community!"),
        ("Mood tip", "Cooking can be a great way to relax and express creativity.")
    ]
    let inspiration: (String, String)
    
    @State private var showBananaBreadSteps = false
    
    init() {
        inspiration = inspirations.randomElement() ?? ("Enjoy your meal!", "Let food brighten your mood today.")
    }
    
    var body: some View {
        Group {
            if inspiration.0 == "Sweet treat inspiration" {
                Button(action: { showBananaBreadSteps = true }) {
                    inspirationCardContent
                }
                .sheet(isPresented: $showBananaBreadSteps) {
                    BananaBreadStepsView()
                }
            } else {
                inspirationCardContent
            }
        }
    }
    
    var inspirationCardContent: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: "lightbulb.fill")
                .font(.system(size: 32))
                .foregroundColor(.yellow)
                .padding(.top, 4)
            VStack(alignment: .leading, spacing: 6) {
                Text(inspiration.0)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(inspiration.1)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 2)
        .padding(.horizontal, 20)
        .padding(.vertical, 8)
    }
}

struct BananaBreadStepsView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("🍌 Banana Bread Recipe")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 8)
                    Text("Ingredients:")
                        .font(.headline)
                    Text("- 3 ripe bananas, mashed\n- 1/3 cup melted butter\n- 1/2 cup sugar\n- 1 egg, beaten\n- 1 tsp vanilla extract\n- 1 tsp baking soda\n- Pinch of salt\n- 1 1/2 cups all-purpose flour")
                        .font(.body)
                        .padding(.bottom, 8)
                    Text("Steps:")
                        .font(.headline)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("1. Preheat oven to 350°F (175°C). Grease a 4x8-inch loaf pan.")
                        Text("2. In a bowl, mix mashed bananas with melted butter.")
                        Text("3. Add sugar, egg, and vanilla. Mix well.")
                        Text("4. Sprinkle baking soda and salt over the mixture. Stir in flour.")
                        Text("5. Pour batter into loaf pan. Bake for 50-60 minutes.")
                        Text("6. Cool, slice, and enjoy with a friend!")
                    }
                    .font(.body)
                }
                .padding()
            }
            .navigationTitle("Banana Bread Steps")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

struct MealSuggestionView: View {
    let mood: Mood
    @Environment(\.dismiss) private var dismiss
    
    var suggestions: [FoodSuggestion] {
        foodSuggestions.filter { $0.mood == mood.name }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(spacing: 12) {
                    Text(mood.emoji)
                        .font(.system(size: 64))
                    
                    Text("Meal Suggestions for \(mood.name)")
                        .font(.system(size: 24, weight: .bold))
                        .multilineTextAlignment(.center)
                    
                    Text("Here are some meals that might help with your mood!")
                        .font(.system(size: 16))
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 40)
                
                if suggestions.isEmpty {
                    Text("No suggestions available for this mood yet.")
                        .foregroundColor(.secondary)
                        .padding()
                } else {
                    VStack(spacing: 16) {
                        ForEach(suggestions) { suggestion in
                            HStack(alignment: .top, spacing: 14) {
                                if let uiImage = UIImage(named: suggestion.imageName) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } else {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color(.systemGray5))
                                        .frame(width: 60, height: 60)
                                        .overlay(
                                            Image(systemName: "fork.knife")
                                                .foregroundColor(.gray)
                                        )
                                }
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(suggestion.name)
                                        .font(.system(size: 16, weight: .semibold))
                                    Text(suggestion.description)
                                        .font(.system(size: 14))
                                        .foregroundColor(.secondary)
                                        .lineLimit(2)
                                }
                                Spacer()
                            }
                            .padding()
                            .background(Color(.systemBackground))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
} 
