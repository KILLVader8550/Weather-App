import Foundation

// Define a structure for the API response
struct Post: Codable {
    let main: Main
    let wind: Wind
    let name: String
    let weather: [Weather]
}
struct Main: Codable {
    let temp: Double
    let pressure: Double
    let humidity: Int
    let temp_min: Double
    let temp_max: Double
}
struct Wind: Codable {
    let speed: Double
}
struct Weather: Codable {
    let description: String
}

// ObservableObject for managing API data
class PostViewModel: ObservableObject {
    @Published var post: Post? // Single post, not an array
    
    func fetchPost() {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=12.24364&lon=102.51514&appid=84322fb5d60db96366c3655d312b5973&units=metric"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                    print("API Response: \(jsonString)")
                }
            
            do {
                let post = try JSONDecoder().decode(Post.self, from: data) // Decoding a single object
                DispatchQueue.main.async {
                    self.post = post
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
