
import Foundation

protocol EntityRepository {
    func fetchEntity(input: String) async throws -> Entity?
}

struct EntityRepositoryImpl: EntityRepository {
    
    private let fileService: FileService
    
    init(fileService: FileService) {
        self.fileService = fileService
    }
    
    func fetchEntity(input: String) async throws -> Entity? {
        guard let url = Bundle.main.url(forResource: "Duck", withExtension: "glb") else { return nil }
        
        return Entity(id: UUID().uuidString, url: url)
    }
}
