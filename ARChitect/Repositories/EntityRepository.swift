
import Foundation

protocol EntityRepository {
    func fetchEntity(input: String) async throws -> Entity?
}

struct EntityRepositoryImpl: EntityRepository {
    
    func fetchEntity(input: String) async throws -> Entity? {
        return Entity(id: "dummy id", url: URL(string: "http://udemy.com")!)
    }
}
