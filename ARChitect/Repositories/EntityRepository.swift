
import Foundation
import UIKit

protocol EntityRepository {
    func fetchEntity(input: String) async throws -> Entity?
}

struct EntityRepositoryImpl: EntityRepository {
    
    private let fileService: FileService
    private let meshRepository: MeshRepository
    
    init(fileService: FileService, meshRepository: MeshRepository) {
        self.fileService = fileService
        self.meshRepository = meshRepository
    }
    
    func fetchEntity(input: String) async throws -> Entity? {
        guard let imageResponse = try await obtainImage(input: input) else { return nil }
        
        guard let meshResponse = try await meshRepository.fetchMesh(imageData: imageResponse) else { return nil }
        
        let id = UUID().uuidString
        let url = try fileService.saveFile(data: meshResponse, filename: "\(id).glb")
                
        return Entity(id: id, url: url)
    }
    
    private func obtainImage(input: String) async throws -> Data? {
        let urlRequest = ImageURLRequestBuilder.buildURLRequest(input: input)
        return try await URLSessionHandler.performRequest(urlRequest)
    }
}
