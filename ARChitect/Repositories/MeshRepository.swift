
import Foundation

protocol MeshRepository {
    func fetchMesh(imageData: Data) async throws -> Data?
}

struct MeshRepositoryImpl: MeshRepository {
    func fetchMesh(imageData: Data) async throws -> Data? {
        let urlRequest = MeshURLRequestBuilder.buildURLRequest(imageData: imageData)
        return try await URLSessionHandler.performRequest(urlRequest)
    }
}
