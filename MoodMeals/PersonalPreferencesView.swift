import SwiftUI

struct PersonalPreferencesView: View {
    @State private var displayName = "Jane Doe"
    @State private var email = "janedoe@email.com"

    var body: some View {
        VStack(spacing: 32) {
            HStack {
                Image(systemName: "gearshape.fill")
                    .foregroundColor(.black)
                Text("Personal Preferences")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding()
            .background(Color(red: 0.85, green: 0.91, blue: 1.0))
            .cornerRadius(8)
            .padding(.top)

            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .clipShape(Circle())
                    Button(action: {}) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.yellow)
                            .background(Circle().fill(Color.white).frame(width: 28, height: 28))
                    }
                    .offset(x: 6, y: 6)
                }
            }

            VStack(alignment: .leading, spacing: 4) {
                Text("Display name")
                    .font(.headline)
                TextField("Display name", text: $displayName)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.vertical, 4)
                Divider()
                Text("Name shown with your posts in community feeds.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 4) {
                Text("Email")
                    .font(.headline)
                TextField("Email", text: $email)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.vertical, 4)
                Divider()
                Text("Used for all email updates and notifications.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)

            Button(action: {}) {
                Text("Reset password")
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
    PersonalPreferencesView()
} 