
import Foundation

protocol EntityRepository {
    func fetchEntity(input: String) async throws -> Entity?
}

struct EntityRepositoryImpl: EntityRepository {
    
    func fetchEntity(input: String) async throws -> Entity? {
        guard let url = Bundle.main.url(forResource: "Duck", withExtension: "glb") else { return nil }
        
        return Entity(id: UUID().uuidString, url: url)
    }
}
