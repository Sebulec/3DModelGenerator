
import Foundation

struct ImageURLRequestBuilder {
    
    private static let url = URL(string: "https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-3.5-large")!
    private static let apiKey = Secrets.imageApiKey

    static func buildURLRequest(input: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = """
        {
            "inputs": "\(input)"
        }
        """.data(using: .utf8)
        return request
    }
}
