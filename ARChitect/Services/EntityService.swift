
import Foundation

final class EntityService: ObservableObject {
    private let entityRepository: EntityRepository
    private let suffix = ", white background"
    
    init(entityRepository: EntityRepository) {
        self.entityRepository = entityRepository
    }
    
    func fetchEntity(input: String) async throws -> Entity? {
        try await entityRepository.fetchEntity(input: input.appending(suffix))
    }
}
