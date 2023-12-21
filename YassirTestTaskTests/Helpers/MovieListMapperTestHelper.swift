import XCTest
@testable import YassirTestTask

final class MovieListMapperTestHelper {
    
    let dateFormatter: DateFormatter = MovieListService(httpClient: HttpClientMock()).dateFormatter
    
    func loadFromJson() -> MovieList? {
        guard let jsonResult = LoadFromJsonHelper.loadFromJson(fileName: "discover")
        else {
            return nil
        }
        
        let decoder =  JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        return try? decoder.decode(MovieList.self, from: jsonResult)
    }
    
}
