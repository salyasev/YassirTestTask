import XCTest
@testable import YassirTestTask

final class MovieListServiceMock: MovieListServiceProtocol {
    func loadMovies(page: Int, completion: @escaping (Result<[YassirTestTask.Movie], YassirTestTask.ApiError>) -> Void) {
        completion(
            .success(
                [Movie(id: 123, title: "test_title", releaseDate: Date(), posterPath: "test.jpg", vote: 9.0, voteCount: 10000000)]
            )
        )
    }
    
}
