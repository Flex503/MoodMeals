import SwiftUI
import PhotosUI
import UIKit

struct Comment: Identifiable {
    let id = UUID()
    let author: String
    let text: String
    let timestamp: String
}

struct CommunityPost: Identifiable {
    let id = UUID()
    let username: String
    let userAvatar: String
    let imageName: String
    let title: String
    let description: String
    let likes: Int
    var comments: [Comment] // Now an array of comments
    let mood: String
    let timestamp: String
}

// Move sampleComments here so it can be used in the posts array initializer
let sampleComments: [Comment] = [
    Comment(author: "Alex", text: "Looks delicious!", timestamp: "2m ago"),
    Comment(author: "Jamie", text: "Can't wait to try this recipe.", timestamp: "5m ago"),
    Comment(author: "Taylor", text: "My family loved it!", timestamp: "10m ago")
]

// Helper to generate a list of comments for demo
func generateComments(count: Int) -> [Comment] {
    let names = ["Alex", "Jamie", "Taylor", "Morgan", "Chris", "Sam", "Jordan", "Casey", "Riley", "Drew", "Avery", "Skyler", "Peyton", "Quinn", "Reese", "Cameron", "Harper", "Rowan", "Sage", "Emerson"]
    let messages = [
        "This looks amazing!",
        "Can't wait to try this.",
        "My family loved it!",
        "So creative!",
        "Perfect for dinner tonight.",
        "Yum!",
        "Recipe please!",
        "I made this last week.",
        "Looks so comforting.",
        "Best meal ever!",
        "Love the colors!",
        "Super easy to make.",
        "Thanks for sharing!",
        "My kids enjoyed it.",
        "Delicious!",
        "Will make again.",
        "Great for meal prep.",
        "So healthy!",
        "Classic treat!",
        "Perfect for busy nights!"
    ]
    var comments: [Comment] = []
    for i in 0..<count {
        let name = names[i % names.count]
        let message = messages[(i + count) % messages.count]
        let timestamp = "\(2 + i * 2)m ago"
        comments.append(Comment(author: name, text: message, timestamp: timestamp))
    }
    return comments
}

struct CommunityView: View {
    @State private var selectedFilter = "All"
    @State private var searchText = ""
    @State private var showNewPostSheet = false
    @State private var newPostTitle = ""
    @State private var newPostDescription = ""
    @State private var newPostMood = "Happy"
    @State private var newPostImage: UIImage? = nil
    @State private var showImagePicker = false
    
    let filters = ["All", "Happy", "Comfort", "Healthy", "Quick", "Desserts"]
    
    @State private var posts: [CommunityPost] = [
        CommunityPost(
            username: "Sarah's Kitchen",
            userAvatar: "person.circle.fill",
            imageName: "food1",
            title: "Cozy Chicken Soup",
            description: "Perfect comfort food for those rainy days 🍲",
            likes: 124,
            comments: generateComments(count: 8),
            mood: "Comfort",
            timestamp: "2h ago"
        ),
        CommunityPost(
            username: "Mike's Meals",
            userAvatar: "person.circle.fill",
            imageName: "food2",
            title: "Energizing Smoothie Bowl",
            description: "Start your day right with this vibrant bowl! 🌈",
            likes: 89,
            comments: generateComments(count: 12),
            mood: "Happy",
            timestamp: "4h ago"
        ),
        CommunityPost(
            username: "Emma's Eats",
            userAvatar: "person.circle.fill",
            imageName: "food3",
            title: "Chocolate Chip Cookies",
            description: "Warm cookies fresh from the oven 🍪",
            likes: 256,
            comments: generateComments(count: 20),
            mood: "Desserts",
            timestamp: "1d ago"
        ),
        CommunityPost(
            username: "Healthy Habits",
            userAvatar: "person.circle.fill",
            imageName: "food4",
            title: "Quinoa Buddha Bowl",
            description: "Nutritious and delicious! 🥗",
            likes: 67,
            comments: generateComments(count: 7),
            mood: "Healthy",
            timestamp: "3h ago"
        ),
        CommunityPost(
            username: "Quick Cook",
            userAvatar: "person.circle.fill",
            imageName: "food5",
            title: "15-Min Pasta",
            description: "When you need something fast and tasty 🍝",
            likes: 143,
            comments: generateComments(count: 15),
            mood: "Quick",
            timestamp: "5h ago"
        ),
        CommunityPost(
            username: "Sweet Treats",
            userAvatar: "person.circle.fill",
            imageName: "food6",
            title: "Berry Cheesecake",
            description: "Summer vibes in every bite 🍰",
            likes: 198,
            comments: generateComments(count: 10),
            mood: "Desserts",
            timestamp: "6h ago"
        )
    ]
    
    var filteredPosts: [CommunityPost] {
        if selectedFilter == "All" {
            return posts
        } else {
            return posts.filter { $0.mood == selectedFilter }
        }
    }
    
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
                    // Header
                    VStack(spacing: 16) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Community")
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundColor(.primary)
                                Text("Share and discover amazing meals")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Button(action: {
                                // Add new post action
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title2)
                                    .foregroundColor(.orange)
                                    .shadow(color: Color.orange.opacity(0.18), radius: 8, x: 0, y: 4)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 10)
                        .background(Color.clear)
                        .cornerRadius(18)
                        .shadow(color: Color.orange.opacity(0.08), radius: 8, x: 0, y: 4)
                        
                        // Search Bar
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.secondary)
                            TextField("Search recipes...", text: $searchText)
                                .textFieldStyle(PlainTextFieldStyle())
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal, 20)
                        
                        // Filter Chips
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(filters, id: \.self) { filter in
                                    FilterChip(
                                        title: filter,
                                        isSelected: selectedFilter == filter
                                    ) {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            selectedFilter = filter
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                    .padding(.bottom, 16)
                    .background(Color.white)
                    
                    // Masonry Grid
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ], spacing: 12) {
                            ForEach(filteredPosts) { post in
                                if let index = posts.firstIndex(where: { $0.id == post.id }) {
                                    CommunityPostCard(post: post, comments: $posts[index].comments)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    }
                    // Add friendly empty state if there are no posts
                    if filteredPosts.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "tray")
                                .font(.system(size: 48))
                                .foregroundColor(.orange)
                            Text("No community posts yet!")
                                .font(.title3).bold()
                                .foregroundColor(.secondary)
                            Text("Be the first to share a meal or recipe with the community.")
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 60)
                    }
                }
                .background(Color(.systemGroupedBackground))
                // Floating + button
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: { showNewPostSheet = true }) {
                            Image(systemName: "plus")
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.white)
                                .padding()
                                .background(Circle().fill(Color.orange).shadow(radius: 8))
                        }
                        .padding(.trailing, 28)
                        .padding(.bottom, 32)
                        .accessibilityLabel("Share a new recipe")
                    }
                }
            }
            .sheet(isPresented: $showNewPostSheet) {
                NewRecipePostSheet(
                    isPresented: $showNewPostSheet,
                    posts: $posts
                )
            }
        }
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(isSelected ? Color.orange : Color(.systemGray5))
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CommunityPostCard: View {
    let post: CommunityPost
    @Binding var comments: [Comment]
    @State private var isLiked = false
    @State private var likeCount: Int
    @State private var showComments = false
    @State private var newCommentText = ""
    
    init(post: CommunityPost, comments: Binding<[Comment]>) {
        self.post = post
        self._comments = comments
        _likeCount = State(initialValue: post.likes)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Image
            Group {
                if post.title == "Cozy Chicken Soup" {
                    if let _ = UIImage(named: "soup1") {
                        Image("soup1")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: 170, height: 170)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.yellow.opacity(0.2))
                            .frame(width: 170, height: 170)
                    }
                } else if post.title == "Energizing Smoothie Bowl" {
                    if let _ = UIImage(named: "smoothiebowl1") {
                        Image("smoothiebowl1")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: 170, height: 170)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.yellow.opacity(0.2))
                            .frame(width: 170, height: 170)
                    }
                } else if post.title == "Chocolate Chip Cookies" {
                    if let _ = UIImage(named: "cookie1") {
                        Image("cookie1")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: 170, height: 170)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.yellow.opacity(0.2))
                            .frame(width: 170, height: 170)
                    }
                } else if post.title == "Quinoa Buddha Bowl" {
                    if let _ = UIImage(named: "buddhabowl1") {
                        Image("buddhabowl1")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: 170, height: 170)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.yellow.opacity(0.2))
                            .frame(width: 170, height: 170)
                    }
                } else if post.title == "15-Min Pasta" {
                    if let _ = UIImage(named: "pasta1") {
                        Image("pasta1")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: 170, height: 170)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.yellow.opacity(0.2))
                            .frame(width: 170, height: 170)
                    }
                } else if post.title == "Berry Cheesecake" {
                    if let _ = UIImage(named: "cheesecake1") {
                        Image("cheesecake1")
                            .resizable()
                            .aspectRatio(1, contentMode: .fill)
                            .frame(width: 170, height: 170)
                            .clipped()
                    } else {
                        Rectangle()
                            .fill(Color.yellow.opacity(0.2))
                            .frame(width: 170, height: 170)
                    }
                } else if post.imageName == "food1" {
                    Image(uiImage: UIImage(named: "group1") ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 170, height: 170)
                        .clipped()
                } else if post.imageName == "food2" {
                    Image(uiImage: UIImage(named: "group2") ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 170, height: 170)
                        .clipped()
                } else if post.imageName == "food3" {
                    Image(uiImage: UIImage(named: "group3") ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: 170, height: 170)
                        .clipped()
                } else {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.orange.opacity(0.3), Color.pink.opacity(0.3)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 170, height: 170)
                }
            }
            .overlay(
                VStack {
                    HStack {
                        Spacer()
                        Button(action: {
                            let generator = UIImpactFeedbackGenerator(style: .light)
                            generator.impactOccurred()
                            isLiked.toggle()
                            likeCount += isLiked ? 1 : -1
                        }) {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .foregroundColor(isLiked ? .red : .white)
                                .font(.title3)
                                .padding(8)
                                .background(Color.black.opacity(0.3))
                                .clipShape(Circle())
                        }
                    }
                    .padding(.top, 8)
                    .padding(.trailing, 8)
                    Spacer()
                }
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            // Content
            VStack(alignment: .leading, spacing: 8) {
                // User info
                HStack {
                    Image(systemName: post.userAvatar)
                        .font(.title3)
                        .foregroundColor(.orange)
                    VStack(alignment: .leading, spacing: 2) {
                        Text(post.username)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.primary)
                        Text(post.timestamp)
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    Text(post.mood)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.orange)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.orange.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                // Title and description
                Text(post.title)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.primary)
                    .lineLimit(2)
                Text(post.description)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                // Engagement
                HStack {
                    HStack(spacing: 4) {
                        Image(systemName: "heart")
                            .font(.caption)
                        Text("\(likeCount)")
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                    Button(action: {
                        let generator = UIImpactFeedbackGenerator(style: .soft)
                        generator.impactOccurred()
                        showComments = true
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "message")
                                .font(.caption)
                            Text("\(comments.count)")
                                .font(.caption)
                        }
                    }
                    .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .padding(12)
        }
        .frame(width: 170, height: 320)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(.systemGray6), Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.orange.opacity(0.08), radius: 8, x: 0, y: 4)
        .sheet(isPresented: $showComments) {
            VStack(spacing: 0) {
                HStack {
                    Text("Comments")
                        .font(.title2).bold()
                    Spacer()
                    Button("Close") { showComments = false }
                        .padding(.horizontal)
                }
                .padding(.top, 16)
                .padding(.bottom, 8)
                .padding(.horizontal)
                Divider()
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(comments) { comment in
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(comment.author)
                                        .font(.headline)
                                    Spacer()
                                    Text(comment.timestamp)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                Text(comment.text)
                                    .font(.body)
                            }
                            .padding(.vertical, 6)
                            .padding(.horizontal)
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }
                Divider()
                HStack {
                    TextField("Add a comment...", text: $newCommentText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        let newComment = Comment(author: "You", text: newCommentText, timestamp: "Now")
                        comments.append(newComment)
                        newCommentText = ""
                    }) {
                        Image(systemName: "paperplane.fill")
                            .foregroundColor(newCommentText.isEmpty ? .gray : .orange)
                    }
                    .disabled(newCommentText.isEmpty)
                }
                .padding()
            }
            .presentationDetents([.medium, .large])
        }
    }
}

struct NewRecipePostSheet: View {
    @Binding var isPresented: Bool
    @Binding var posts: [CommunityPost]
    @State private var title = ""
    @State private var description = ""
    @State private var mood = "Happy"
    @State private var image: UIImage? = nil
    @State private var showImagePicker = false
    let moods = ["Happy", "Comfort", "Healthy", "Quick", "Desserts"]
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Text("Share a Recipe")
                        .font(.title).bold()
                        .padding(.top, 12)
                    Button(action: { showImagePicker = true }) {
                        if let image = image {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
                                .overlay(RoundedRectangle(cornerRadius: 18).stroke(Color.orange, lineWidth: 2))
                        } else {
                            VStack {
                                Image(systemName: "photo.on.rectangle")
                                    .font(.system(size: 40))
                                    .foregroundColor(.orange)
                                Text("Add Photo")
                                    .foregroundColor(.orange)
                            }
                            .frame(width: 120, height: 120)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 18))
                        }
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(image: $image)
                    }
                    TextField("Recipe Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    TextField("Description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                    Picker("Mood", selection: $mood) {
                        ForEach(moods, id: \.self) { mood in
                            Text(mood)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                    Button(action: {
                        let newPost = CommunityPost(
                            username: "You",
                            userAvatar: "person.circle.fill",
                            imageName: "", // We'll use the image directly
                            title: title,
                            description: description,
                            likes: 0,
                            comments: [],
                            mood: mood,
                            timestamp: "Just now"
                        )
                        posts.insert(newPost, at: 0)
                        isPresented = false
                    }) {
                        Text("Share Recipe")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(title.isEmpty || description.isEmpty ? Color.gray : Color.orange)
                            .cornerRadius(12)
                    }
                    .disabled(title.isEmpty || description.isEmpty)
                    .padding(.horizontal)
                }
                .padding(.bottom, 32)
            }
            .navigationBarItems(leading: Button("Cancel") { isPresented = false })
        }
    }
}

// Simple ImagePicker for UIKit integration
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        init(_ parent: ImagePicker) { self.parent = parent }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

#Preview {
    CommunityView()
} 