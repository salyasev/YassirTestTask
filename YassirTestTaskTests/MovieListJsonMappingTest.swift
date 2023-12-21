import XCTest
@testable import YassirTestTask

final class MovieListJsonMappingTest: XCTestCase {


    func testMovieListJsonMapping() throws {
        // given
        let helper = MovieListMapperTestHelper()
        let moviesList = helper.loadFromJson()
        
        // then
        XCTAssertNotNil(moviesList)
        XCTAssertEqual(moviesList?.page, 1)
        XCTAssertEqual(moviesList?.results.count, 20)
        XCTAssertEqual(moviesList?.results[0].id, 787699)
        XCTAssertEqual(moviesList?.results[0].title, "Wonka")
        XCTAssertEqual(moviesList?.results[0].posterPath, "/qhb1qOilapbapxWQn9jtRCMwXJF.jpg")
        XCTAssertEqual(moviesList?.results[0].vote, 7.3)
        XCTAssertEqual(moviesList?.results[0].voteCount, 386)
        XCTAssertNotNil(moviesList?.results[0].releaseDate)
        if let date = moviesList?.results[0].releaseDate {
            XCTAssertEqual(helper.dateFormatter.string(from: date), "2023-12-06")
        }
        
        // add other checks
    }
    
    func testMovieDetailsJsonMapping() throws {
        // given
        let helper = MovieListMapperTestHelper()
        let moviesList = helper.loadFromJson()
        
        // then
        XCTAssertNotNil(moviesList)
        XCTAssertEqual(moviesList?.page, 1)
        XCTAssertEqual(moviesList?.results.count, 20)
        XCTAssertEqual(moviesList?.results[0].id, 787699)
        XCTAssertEqual(moviesList?.results[0].title, "Wonka")
        XCTAssertEqual(moviesList?.results[0].posterPath, "/qhb1qOilapbapxWQn9jtRCMwXJF.jpg")
        XCTAssertEqual(moviesList?.results[0].vote, 7.3)
        XCTAssertEqual(moviesList?.results[0].voteCount, 386)
        XCTAssertNotNil(moviesList?.results[0].releaseDate)
        if let date = moviesList?.results[0].releaseDate {
            XCTAssertEqual(helper.dateFormatter.string(from: date), "2023-12-06")
        }
        
        // add other checks
    }

}
