import SwiftUI

struct CommunityPreferencesView: View {
    @State private var privatePosts = true
    @State private var commentNotifications = true
    @State private var receiveHighlights = false

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Image(systemName: "face.smiling")
                Text("Community Preferences")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            .background(Color(red: 0.85, green: 0.91, blue: 1.0))
            .cornerRadius(8)

            NavigationLink(destination: Text("Manage Communities")) {
                HStack {
                    Text("Manage communities")
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
            }

            Toggle(isOn: $privatePosts) {
                VStack(alignment: .leading) {
                    Text("Private posts").fontWeight(.semibold)
                    Text("Hide your posts from other users.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)

            Toggle(isOn: $commentNotifications) {
                VStack(alignment: .leading) {
                    Text("Comment notifications").fontWeight(.semibold)
                    Text("Get notified when someone comments on your post.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal)

            Toggle(isOn: $receiveHighlights) {
                VStack(alignment: .leading) {
                    Text("Receive community highlights").fontWeight(.semibold)
                    Text("Sent to your account email address.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
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
    CommunityPreferencesView()
} 