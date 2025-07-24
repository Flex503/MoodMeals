import SwiftUI
import AVFoundation
import UIKit

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
    let timestamp: Date
    let isError: Bool
    
    init(text: String, isFromUser: Bool, timestamp: Date = Date(), isError: Bool = false) {
        self.text = text
        self.isFromUser = isFromUser
        self.timestamp = timestamp
        self.isError = isError
    }
}

// Remove import Speech and SpeechRecognizer usage
import SwiftUI
import AVFoundation
import UIKit

// Remove SpeechRecognizer implementation

// Remove @MainActor from ChatView
struct ChatView: View {
    @State private var messageText = ""
    @State private var messages: [Message] = [
        Message(text: "Welcome to MoodMeals! How are you feeling today?", isFromUser: false)
    ]
    @State private var isLoading = false
    // Removed: @StateObject private var recognizer = SpeechRecognizer()
    // Removed: @State private var showVoiceInstructions = false
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            VStack(spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Welcome to MoodMeals")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                        Text("Let us guide you on a culinary journey of comfort.")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                    Spacer()
                    Image(systemName: "fork.knife")
                        .font(.title2)
                        .foregroundColor(.orange)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 12)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.12), Color(UIColor.systemGray6)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .shadow(color: Color.orange.opacity(0.08), radius: 8, x: 0, y: 4)
            Divider().background(Color(.systemGray4))
            // Messages
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                        }
                        if isLoading {
                            HStack {
                                Spacer()
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .padding(.vertical, 8)
                                Spacer()
                            }
                            .id("loading")
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                .onChange(of: messages.count) { _ in
                    withAnimation(.easeOut(duration: 0.3)) {
                        if let last = messages.last {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }
            }
            Divider().background(Color(.systemGray4))
            // Input area
            HStack(spacing: 12) {
                TextField("Type your message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(isLoading)
                    .padding(.leading)
                Button(action: sendMessage) {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                .disabled(messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isLoading)
                .padding(.trailing)
                // Removed: Microphone button and related UI
            }
            .padding(.vertical, 8)
            .background(Color(UIColor.systemBackground))
            // Removed: Listening and transcribed text UI
        }
        .background(Color(UIColor.systemGroupedBackground))
    }
    
    private func mealSuggestion(for message: String) -> String {
        let lowercased = message.lowercased()
        if lowercased.contains("happy") {
            return "You seem happy! How about a Mango Salsa with tortilla chips or a Lemon Ricotta Pancake?"
        } else if lowercased.contains("sad") {
            return "Feeling down? Try a bowl of Chicken Noodle Soup or a slice of Warm Apple Pie."
        } else if lowercased.contains("tired") {
            return "Need energy? A Peanut Butter Banana Toast or a Chia Pudding Parfait could help!"
        } else if lowercased.contains("stressed") {
            return "Stressed? Enjoy a Green Matcha Latte or a bowl of Miso Soup to unwind."
        } else if lowercased.contains("excited") {
            return "Excited! Celebrate with a Spicy Tuna Roll or a slice of Funfetti Cake."
        } else if lowercased.contains("calm") {
            return "For a calm mood, try a Lavender Honey Latte or a bowl of Oatmeal with blueberries."
        } else if lowercased.contains("mad") || lowercased.contains("angry") {
            return "Feeling mad? Crunch on some Spicy Roasted Chickpeas or try a hearty BBQ Chicken Pizza."
        } else if lowercased.contains("anxious") || lowercased.contains("anxiety") {
            return "Anxious? Sip on a Chamomile & Honey Tea or enjoy a bowl of Creamy Polenta."
        } else if lowercased.contains("bored") {
            return "Bored? Try making DIY Sushi Rolls or a creative Veggie Quesadilla!"
        } else if lowercased.contains("grateful") || lowercased.contains("thankful") {
            return "Grateful? Celebrate with a homemade Apple Crisp or a Caprese Salad."
        } else if lowercased.contains("lonely") {
            return "Feeling lonely? A comforting bowl of Ramen or a classic Grilled Cheese Sandwich can help."
        } else if lowercased.contains("motivated") {
            return "Motivated! Fuel up with a Protein Power Bowl or a Quinoa & Roasted Veggie Salad."
        } else if lowercased.contains("nostalgic") {
            return "Nostalgic? Enjoy some Macaroni Salad or a slice of Banana Bread like old times."
        } else if lowercased.contains("sick") || lowercased.contains("ill") {
            return "Not feeling well? Try some Ginger Lemon Tea or a bowl of Chicken Congee."
        } else if lowercased.contains("overwhelmed") {
            return "Overwhelmed? A simple Avocado Toast or a bowl of Greek Yogurt with honey can be soothing."
        } else if lowercased.contains("hopeful") {
            return "Hopeful? Enjoy a Spring Veggie Risotto or a Berry Smoothie!"
        } else if lowercased.contains("relaxed") {
            return "Relaxed? Sip on a Mint Iced Tea or enjoy a Mediterranean Mezze Plate."
        } else if lowercased.contains("confident") {
            return "Confident! Treat yourself to a Steak Fajita Bowl or a gourmet Flatbread Pizza."
        } else if lowercased.contains("scared") || lowercased.contains("afraid") {
            return "Scared? A warm bowl of Tomato Basil Soup or a Chocolate Chip Cookie can bring comfort."
        } else {
            return "Tell me how you're feeling, and I'll suggest a meal for your mood!"
        }
    }

    private func sendMessage() {
        let trimmedText = messageText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedText.isEmpty else { return }
        let userMessage = Message(text: trimmedText, isFromUser: true)
        messages.append(userMessage)
        messageText = ""
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let suggestion = mealSuggestion(for: trimmedText)
            let botMessage = Message(text: suggestion, isFromUser: false)
            messages.append(botMessage)
            isLoading = false
        }
    }
    
    private func appendErrorMessage(_ text: String) {
        DispatchQueue.main.async {
            let errorMessage = Message(text: text, isFromUser: false, isError: true)
            messages.append(errorMessage)
        }
    }
}

struct MessageBubble: View {
    let message: Message
    // Removed: @State private var isSpeaking, AVSpeechSynthesizer, Coordinator, and related state
    var body: some View {
        HStack {
            if message.isFromUser {
                Spacer()
            }
            VStack(alignment: message.isFromUser ? .trailing : .leading, spacing: 4) {
                HStack(alignment: .center, spacing: 8) {
                    Text(message.text)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(bubbleBackground())
                        .foregroundColor(message.isFromUser ? .white : (message.isError ? .red : .primary))
                        .cornerRadius(18)
                        .shadow(color: message.isFromUser ? Color.blue.opacity(0.10) : Color.orange.opacity(0.06), radius: 4, x: 0, y: 2)
                    // Removed: Speaker button and text-to-speech logic
                }
                Text(formatTime(message.timestamp))
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 4)
            }
            if !message.isFromUser {
                Spacer()
            }
        }
    }
    @ViewBuilder
    private func bubbleBackground() -> some View {
        if message.isFromUser {
            LinearGradient(
                gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else if message.isError {
            Color.red.opacity(0.2)
        } else {
            LinearGradient(
                gradient: Gradient(colors: [Color(UIColor.systemGray5), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    ChatView()
} 
