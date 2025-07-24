import SwiftUI

struct PrivacySettingsView: View {
    @State private var aiPersonalizations = true
    @State private var shareResponses = false

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Image(systemName: "exclamationmark.circle.fill")
                Text("Privacy Settings")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            .background(Color(red: 0.85, green: 0.91, blue: 1.0))
            .cornerRadius(8)

            Toggle(isOn: $aiPersonalizations) {
                Text("Toggle AI personalizations")
            }
            .padding(.horizontal)
            Text("Allow AI to personalize my experience.")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            Toggle(isOn: $shareResponses) {
                Text("Share responses with AI")
            }
            .padding(.horizontal)
            Text("Allow AI to use my responses for data insights.")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            NavigationLink(destination: Text("Data Usage Summary")) {
                Text("Data usage summary")
                    .padding()
            }
            NavigationLink(destination: Text("Privacy Policy")) {
                Text("View privacy policy")
                    .padding()
            }

            Text("Pressing this button below will delete your AI interaction history and reset personalization. This will not delete your chat history.")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            Button(action: {}) {
                Text("Clear AI history")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(red: 1.0, green: 0.8, blue: 0.8))
                    .foregroundColor(.black)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .background(Color.white)
        .cornerRadius(12)
        .padding()
    }
}

#Preview {
    PrivacySettingsView()
} 