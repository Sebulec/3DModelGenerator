
import Foundation

struct URLSessionHandler {
    static func performRequest(_ urlRequest: URLRequest) async throws -> Data? {
        let result = try await URLSession.shared.data(for: urlRequest)
        if let error = handleResponse(result.1) {
            throw error
        }
        return result.0
    }
    
    private static func handleResponse(_ response: URLResponse?) -> Error? {
        print("Response: \(response.debugDescription)")
        guard let httpResponse = response as? HTTPURLResponse else {
            return URLError(.badServerResponse)
        }
        
        if httpResponse.statusCode == 200 {
            return nil
        } else {
            return URLError(.badServerResponse)
        }
    }
}
