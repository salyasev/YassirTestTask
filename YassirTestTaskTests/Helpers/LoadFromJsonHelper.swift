import XCTest
@testable import YassirTestTask

final class LoadFromJsonHelper {
    
    static func loadFromJson(fileName: String) -> Data? {
        guard let url = Bundle(for: LoadFromJsonHelper.self).url(forResource: fileName, withExtension: "json"),
            let data = try? Data(contentsOf: url)
        else {
            return nil
        }
        
        return data
    }
    
}

