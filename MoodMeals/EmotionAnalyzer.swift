import Foundation

class EmotionAnalyzer {
    static let shared = EmotionAnalyzer()
    private let apiKey = "YOUR_OPENAI_API_KEY" // <-- Replace with your key

    func analyzeEmotion(text: String, completion: @escaping (String?) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "system", "content": "You are an emotion analysis assistant. Given a user's message, respond with the primary emotion (e.g., happy, sad, angry, excited, anxious, calm, etc.) and a short explanation."],
                ["role": "user", "content": "Analyze the emotion in this text: \(text)"]
            ],
            "max_tokens": 50
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        URLSession.shared.dataTask(with: request) { data, _, _ in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let choices = json["choices"] as? [[String: Any]],
                  let message = choices.first?["message"] as? [String: Any],
                  let content = message["content"] as? String else {
                completion(nil)
                return
            }
            completion(content.trimmingCharacters(in: .whitespacesAndNewlines))
        }.resume()
    }
} 