
import Foundation

protocol FileService {
    func saveFile(data: Data, filename: String) throws -> URL
}

struct FileServiceImpl: FileService {
    func saveFile(data: Data, filename: String) throws -> URL {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(filename)
        try data.write(to: fileURL)
        
        return fileURL
    }
}
