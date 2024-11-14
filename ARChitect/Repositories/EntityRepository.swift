
import Foundation
import UIKit

protocol EntityRepository {
    func fetchEntity(input: String) async throws -> Entity?
}

struct EntityRepositoryImpl: EntityRepository {
    
    private let fileService: FileService
    
    init(fileService: FileService) {
        self.fileService = fileService
    }
    
    func fetchEntity(input: String) async throws -> Entity? {
        guard let imageResponse = try await obtainImage(input: input) else { return nil }
        
        print(imageResponse)
        let image = UIImage(data: imageResponse)
        
        guard let url = Bundle.main.url(forResource: "Duck", withExtension: "glb") else { return nil }
        
        return Entity(id: UUID().uuidString, url: url)
    }
    
    private func obtainImage(input: String) async throws -> Data? {
        let urlRequest = ImageURLRequestBuilder.buildURLRequest(input: input)
        return try await URLSessionHandler.performRequest(urlRequest)
    }
}
