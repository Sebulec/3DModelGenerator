
import Foundation

final class EntityService: ObservableObject {
    private let entityRepository: EntityRepository
    
    init(entityRepository: EntityRepository) {
        self.entityRepository = entityRepository
    }
    
    func fetchEntity(input: String) async throws -> Entity? {
        try await entityRepository.fetchEntity(input: input)
    }
}
