import XCTest
@testable import YassirTestTask

final class MovieListRouterMock: MovieListRouterProtocol {
    
    func showMovieDetails(movie: YassirTestTask.Movie) { }
    func showError(text: String) { }

}
