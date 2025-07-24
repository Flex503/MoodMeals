//
//  ContentView.swift
//  MoodMeals
//
//  Created by 50GOParticipant on 7/10/25.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding: Bool = false
    
    var body: some View {
        if !hasCompletedOnboarding {
            OnboardingView()
        } else {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                ChatView()
                    .tabItem {
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text("Chat")
                    }
                CommunityView()
                    .tabItem {
                        Image(systemName: "person.3")
                        Text("Community")
                    }
                ProfileView()
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
