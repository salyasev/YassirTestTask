import XCTest
@testable import YassirTestTask

final class MovieListPresenterTest: XCTestCase {


    func testMovieListPresenter() throws {
        // given
        let router: MovieListRouterProtocol = MovieListRouterMock()
        let movieListServiceMock: MovieListServiceProtocol = MovieListServiceMock()
        let interface = MovieListViewInterfaceMock()
        let presenter = MovieListPresenter(view: interface, router: router, movieListService: movieListServiceMock)
              
        // then
        XCTAssertNotNil(presenter.title)
        XCTAssertNotNil(presenter.cellItems)
        XCTAssertEqual(presenter.title, "Movies")
        XCTAssertEqual(presenter.cellItems.count, 1)
        XCTAssertEqual(presenter.movies[0].id, 123)
        XCTAssertEqual(presenter.movies[0].title, "test_title")
        XCTAssertEqual(presenter.cellItems[0].vote, "Score: 9.0 (10000000)")
        // add other checks
        
        // imporovement:
        // conform type itself to Equatable, rather than having multiple asserts in a test
        // some assertions could be handled in separate unit tests
    }
    
    func testMovieListPresenterLoadMoreTest() throws {
        // given
        let router: MovieListRouterProtocol = MovieListRouterMock()
        let movieListServiceMock: MovieListServiceProtocol = MovieListServiceMock()
        let interface = MovieListViewInterfaceMock()
        let presenter = MovieListPresenter(view: interface, router: router, movieListService: movieListServiceMock)
        presenter.loadMoreDataIfNeeded(index: 0)
        
        // then
        XCTAssertNotNil(presenter.cellItems)
        XCTAssertEqual(presenter.cellItems.count, 2)
        // add other checks
    }
    
    // add other tests

}
