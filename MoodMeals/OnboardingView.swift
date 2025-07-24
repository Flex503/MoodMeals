import SwiftUI

struct OnboardingView: View {
    @State private var step = 0
    @State private var selectedMood: String? = nil
    @State private var selectedAllergies: Set<String> = []
    @State private var selectedPreferences: Set<String> = []
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    
    let moods = ["Happy", "Sad", "Tired", "Stressed", "Excited", "Hungry"]
    let allergies = ["Dairy", "Egg", "Peanut", "Tree Nut", "Fish", "Shellfish", "Wheat", "Soy", "Sesame"]
    let preferences = ["Vegetarian", "Vegan", "Low Carb", "Gluten-Free", "Dairy-Free", "Organic", "High Protein"]
    
    var body: some View {
        VStack(spacing: 32) {
            Spacer()
            if step == 0 {
                VStack(spacing: 16) {
                    Text("Welcome to MoodMeals!")
                        .font(.largeTitle).bold()
                    Text("Let's get to know you so we can suggest the best meals for your mood and needs.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
            } else if step == 1 {
                VStack(spacing: 16) {
                    Text("How are you feeling today?")
                        .font(.title2).bold()
                    HStack(spacing: 12) {
                        ForEach(moods, id: \.self) { mood in
                            Button(action: { selectedMood = mood }) {
                                Text(mood)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 18)
                                    .background(selectedMood == mood ? Color.white : Color.white)
                                    .foregroundColor(selectedMood == mood ? .blue : .primary)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(selectedMood == mood ? Color.blue : Color.gray.opacity(0.3), lineWidth: 2)
                                    )
                                    .cornerRadius(16)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
            } else if step == 2 {
                VStack(spacing: 16) {
                    Text("Do you have any allergies?")
                        .font(.title2).bold()
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(allergies, id: \.self) { allergy in
                            Button(action: {
                                if selectedAllergies.contains(allergy) {
                                    selectedAllergies.remove(allergy)
                                } else {
                                    selectedAllergies.insert(allergy)
                                }
                            }) {
                                HStack {
                                    Text(allergy)
                                    if selectedAllergies.contains(allergy) {
                                        Image(systemName: "checkmark.circle.fill").foregroundColor(.blue)
                                    }
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 12)
                                .background(Color.white)
                                .foregroundColor(selectedAllergies.contains(allergy) ? .blue : .primary)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(selectedAllergies.contains(allergy) ? Color.blue : Color.gray.opacity(0.3), lineWidth: 2)
                                )
                                .cornerRadius(14)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
            } else if step == 3 {
                VStack(spacing: 16) {
                    Text("Any food preferences?")
                        .font(.title2).bold()
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        ForEach(preferences, id: \.self) { pref in
                            Button(action: {
                                if selectedPreferences.contains(pref) {
                                    selectedPreferences.remove(pref)
                                } else {
                                    selectedPreferences.insert(pref)
                                }
                            }) {
                                HStack {
                                    Text(pref)
                                    if selectedPreferences.contains(pref) {
                                        Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                                    }
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 12)
                                .background(Color.white)
                                .foregroundColor(selectedPreferences.contains(pref) ? .green : .primary)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(selectedPreferences.contains(pref) ? Color.green : Color.gray.opacity(0.3), lineWidth: 2)
                                )
                                .cornerRadius(14)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
            } else if step == 4 {
                VStack(spacing: 16) {
                    Text("You're all set!")
                        .font(.title2).bold()
                    Text("Enjoy personalized meal suggestions based on your mood and preferences.")
                        .font(.title3)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .background(Color.white)
            }
            Spacer()
            HStack {
                if step > 0 && step < 4 {
                    Button("Back") { step -= 1 }
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
                        )
                        .cornerRadius(12)
                }
                Spacer()
                if step < 4 {
                    Button(step == 3 ? "Finish" : "Next") {
                        if step == 3 {
                            hasCompletedOnboarding = true
                        } else {
                            step += 1
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(14)
                    .disabled((step == 1 && selectedMood == nil))
                }
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 32)
        }
        .background(Color.white.ignoresSafeArea())
        .animation(.easeInOut, value: step)
    }
}

#Preview {
    OnboardingView()
} 