import SwiftUI

struct ProfileView: View {
    @State private var allergies: [String] = ["Peanuts", "Dairy, luten"]
    @State private var foodPreferences: [String] = ["Vegetarian", "Low Carb", "Organic"]
    @State private var notificationsEnabled = true
    @State private var showEmail = false
    @State private var showProfileInCommunity = true
    @State private var allowMessages = true
    @State private var isPrivateAccount = false
    @State private var showingAllergiesSheet = false
    @State private var showingPreferencesSheet = false
    // Add state for new settings
    @State private var showPersonalSettings = false
    @State private var showCommunitySettings = false
    @State private var showPrivacySettings = false
    
    // Allergy toggles
    @State private var dairyAllergies = true
    @State private var eggAllergies = true
    @State private var peanutAllergies = true
    @State private var treeNutAllergies = true
    @State private var fishAllergies = false
    @State private var shellfishAllergies = false
    @State private var wheatAllergies = true
    @State private var soyAllergies = false
    @State private var sesameAllergies = false
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.12), Color(UIColor.systemGray6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea(edges: .top)
                VStack(spacing: 0) {
                    // Profile Header
                    VStack(spacing: 16) {
                        Circle()
                            .fill(Color(.systemGray4))
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray)
                            )
                        
                        Text("My Profile")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 24)
                    .background(Color.clear)
                    .cornerRadius(24)
                    .shadow(color: Color.yellow.opacity(0.10), radius: 8, x: 0, y: 4)
                    
                    // Settings Menu
                    VStack(spacing: 0) {
                        // Allergies Card
                        SettingsCard(
                            title: "Allergies",
                            icon: "exclamationmark.triangle.fill",
                            iconColor: .red,
                            isSelected: showingAllergiesSheet
                        ) {
                            showingAllergiesSheet = true
                        }
                        
                        // Food Preferences Card
                        SettingsCard(
                            title: "Food preferences",
                            icon: "fork.knife",
                            iconColor: .orange,
                            isSelected: showingPreferencesSheet
                        ) {
                            showingPreferencesSheet = true
                        }
                        
                        // Personal Settings Card
                        SettingsCard(
                            title: "Personal settings",
                            icon: "gearshape.fill",
                            iconColor: .blue,
                            isSelected: showPersonalSettings
                        ) {
                            showPersonalSettings = true
                        }
                        
                        // Community Settings Card
                        SettingsCard(
                            title: "Community settings",
                            icon: "person.3.fill",
                            iconColor: .green,
                            isSelected: showCommunitySettings
                        ) {
                            showCommunitySettings = true
                        }
                        
                        // Privacy Settings Card
                        SettingsCard(
                            title: "Privacy settings",
                            icon: "exclamationmark.circle.fill",
                            iconColor: .purple,
                            isSelected: showPrivacySettings
                        ) {
                            showPrivacySettings = true
                        }
                    }
                    .background(Color(.systemGray6))
                    .cornerRadius(18)
                    .shadow(color: Color.orange.opacity(0.08), radius: 8, x: 0, y: 4)
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Spacer()
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Profile Page")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingAllergiesSheet) {
                AllergiesDetailView(
                    dairyAllergies: $dairyAllergies,
                    eggAllergies: $eggAllergies,
                    peanutAllergies: $peanutAllergies,
                    treeNutAllergies: $treeNutAllergies,
                    fishAllergies: $fishAllergies,
                    shellfishAllergies: $shellfishAllergies,
                    wheatAllergies: $wheatAllergies,
                    soyAllergies: $soyAllergies,
                    sesameAllergies: $sesameAllergies
                )
            }
            .sheet(isPresented: $showingPreferencesSheet) {
                PreferencesView()
            }
            // Add sheets for new settings
            .sheet(isPresented: $showPersonalSettings) {
                PersonalPreferencesView()
            }
            .sheet(isPresented: $showCommunitySettings) {
                CommunityPreferencesView()
            }
            .sheet(isPresented: $showPrivacySettings) {
                PrivacySettingsView()
            }
        }
    }
}

struct SettingsCard: View {
    let title: String
    let icon: String
    let iconColor: Color
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {                // Icon
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(iconColor)
                    .frame(width: 24, height: 24)
                
                // Title
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
                
                Spacer()
                
                // Chevron
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color.white, Color(.systemGray6)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(14)
            .shadow(color: Color.orange.opacity(0.06), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct AllergiesDetailView: View {
    @Binding var dairyAllergies: Bool
    @Binding var eggAllergies: Bool
    @Binding var peanutAllergies: Bool
    @Binding var treeNutAllergies: Bool
    @Binding var fishAllergies: Bool
    @Binding var shellfishAllergies: Bool
    @Binding var wheatAllergies: Bool
    @Binding var soyAllergies: Bool
    @Binding var sesameAllergies: Bool
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {                // Header
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.title2)
                        .foregroundColor(.red)
                    Text("Allergies")
                        .font(.system(size: 24, weight: .bold))
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 30)
                
                // Allergy Categories
                ScrollView {
                    VStack(spacing: 0) {
                        AllergyToggleRow(
                            title: "Dairy allergies",
                            subtitle: "Includes allergies to milk, cheese, butter, yogurt, cream, ice cream, etc.",
                            isOn: $dairyAllergies
                        )
                        
                        AllergyToggleRow(
                            title: "Egg allergies",
                            subtitle: "Includes allergies to eggs, egg whites, egg yolks, and products containing eggs",
                            isOn: $eggAllergies
                        )
                        
                        AllergyToggleRow(
                            title: "Peanut allergies",
                            subtitle: "Includes allergies to peanuts, peanut butter, and products containing peanuts",
                            isOn: $peanutAllergies
                        )
                        
                        AllergyToggleRow(
                            title: "Tree nut allergies",
                            subtitle: "Includes almonds, walnuts, cashews, hazelnuts, pistachios, Brazil nuts",
                            isOn: $treeNutAllergies
                        )
                        
                        AllergyToggleRow(
                            title: "Fish allergies",
                            subtitle: "Includes salmon, tuna, cod, catfish",
                            isOn: $fishAllergies
                        )
                        
                        AllergyToggleRow(
                            title: "Shellfish allergies",
                            subtitle: "Includes shrimp, crab, lobster, scallops, clams, squid",
                            isOn: $shellfishAllergies
                        )
                        
                        AllergyToggleRow(
                            title: "Wheat allergies",
                            subtitle: "Includes bread, pasta, cereals, sauces",
                            isOn: $wheatAllergies
                        )
                        
                        AllergyToggleRow(
                            title: "Soy allergies",
                            subtitle: "Includes soy milk, tofu, soy sauce, edamame",
                            isOn: $soyAllergies
                        )
                        
                        AllergyToggleRow(
                            title: "Sesame allergies",
                            subtitle: "Includes allergies to sesame seeds",
                            isOn: $sesameAllergies
                        )
                    }
                    .padding(.horizontal, 20)
                }
            }
            .background(Color(.systemGroupedBackground))
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

struct AllergyToggleRow: View {
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                
                Spacer()
                
                Toggle("", isOn: $isOn)
                    .labelsHidden()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.white)
            
            Divider()
                .padding(.leading, 20)
        }
    }
}

struct PreferencesView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var vegetarian = false
    @State private var vegan = false
    @State private var pescatarian = false
    @State private var lactoseFree = false
    @State private var glutenFree = false
    @State private var lowCarb = false
    @State private var halalKosher = false
    @State private var wholeFood = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                // Header
                VStack(alignment: .leading, spacing: 4) {
                    Text("Food Preferences Page")
                        .font(.caption)
                        .foregroundColor(.blue)
                    Text("Food Preferences")
                        .font(.system(size: 28, weight: .bold))
                        .padding(.bottom, 8)
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 8)
                .background(Color.white)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(Color.blue.opacity(0.2)), alignment: .bottom
                )
                // Preferences List
                ScrollView {
                    VStack(spacing: 0) {
                        PreferenceToggleRow(title: "Vegetarian", subtitle: "Excludes meat, poultry, and fish.", isOn: $vegetarian)
                        PreferenceToggleRow(title: "Vegan", subtitle: "Excludes all animal products.", isOn: $vegan)
                        PreferenceToggleRow(title: "Pescatarian", subtitle: "Excludes meat and poultry, but includes fish and seafood.", isOn: $pescatarian)
                        PreferenceToggleRow(title: "Lactose-free", subtitle: "Avoids milk and dairy products.", isOn: $lactoseFree)
                        PreferenceToggleRow(title: "Gluten-free", subtitle: "Avoids wheat, barley, and rye products.", isOn: $glutenFree)
                        PreferenceToggleRow(title: "Low-Carb / Keto", subtitle: "Limits carbohydrate intake, and emphasizes fats and proteins.", isOn: $lowCarb)
                        PreferenceToggleRow(title: "Halal / Kosher", subtitle: "Follows religious dietary laws.", isOn: $halalKosher)
                        PreferenceToggleRow(title: "Whole Food / Clean Eating", subtitle: "Focuses on minimally processed foods, often avoiding additives, preservatives, and refined sugars.", isOn: $wholeFood)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
                Spacer()
            }
            .background(Color(.systemGray6))
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

struct PreferenceToggleRow: View {
    let title: String
    let subtitle: String
    @Binding var isOn: Bool
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.primary)
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                Spacer()
                Toggle("", isOn: $isOn)
                    .toggleStyle(SwitchToggleStyle(tint: Color.blue))
                    .labelsHidden()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 18)
            Divider()
                .padding(.leading, 20)
        }
    }
}

struct PreferenceChip: View {
    let preference: String
    let isAddable: Bool
    let action: () -> Void
    
    init(preference: String, isAddable: Bool = false, action: @escaping () -> Void) {
        self.preference = preference
        self.isAddable = isAddable
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(preference)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isAddable ? .orange : .white)
                
                if isAddable {
                    Image(systemName: "plus")
                        .font(.caption)
                        .foregroundColor(.orange)
                } else {
                    Image(systemName: "xmark")
                        .font(.caption)
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isAddable ? Color.orange.opacity(0.1) : Color.green.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isAddable ? Color.orange : Color.clear, lineWidth: 1)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ProfileView()
} 