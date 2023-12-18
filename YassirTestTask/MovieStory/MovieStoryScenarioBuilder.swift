import Foundation
import UIKit

protocol MovieStoryScenarioBuilderProtocol: AnyObject {
    
    func makeMovieListViewController() -> MovieListViewController
    func makeMovieDetailsViewController(movieId: String) -> MovieDatailsViewController
    
}

final class MovieStoryScenarioBuilder: MovieStoryScenarioBuilderProtocol {
    
    // MARK: - MovieStoryScenarioBuilderProtocol
    func makeMovieListViewController() -> MovieListViewController {
        let vc = MovieListViewController()
        return vc
    }
    
    func makeMovieDetailsViewController(movieId: String) -> MovieDatailsViewController {
        print(movieId)
        return MovieDatailsViewController()
    }
    
}

