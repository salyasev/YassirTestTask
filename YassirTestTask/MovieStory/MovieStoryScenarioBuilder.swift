import Foundation
import UIKit

protocol MovieStoryScenarioBuilderProtocol: AnyObject {
    
    func makeMovieListViewController() -> MovieListViewController
    func makeMovieDetailsViewController(movie: Movie) -> MovieDatailsViewController
    
}

final class MovieStoryScenarioBuilder: MovieStoryScenarioBuilderProtocol {
    
    // MARK: - MovieStoryScenarioBuilderProtocol
    func makeMovieListViewController() -> MovieListViewController {
        // TODO: inject dependencies via DI container - services could be lazy loaded, singletones, etc.
        let vc = MovieListViewController()
        let router = MovieListRouter(
            viewController: vc,
            scenarioBuilder: self
        )
        let httpClient = HttpClient()
        let movieListService = MovieListService(httpClient: httpClient)
        let presenter = MovieListPresenter(
            view: vc,
            router: router,
            movieListService: movieListService
        )
        // better to add presenter disposable
        vc.setup(presenter: presenter)
        
        return vc
    }
    
    func makeMovieDetailsViewController(movie: Movie) -> MovieDatailsViewController {
        // TODO: inject dependencies via DI container - some services could be lazy loaded or singletones, etc.
        let vc = MovieDatailsViewController()
        let router = MovieDetailsRouter(viewController: vc)
        let httpClient = HttpClient()
        let movieDetailsService = MovieDetailsService(httpClient: httpClient)
        let presenter = MovieDetailsPresenter(
            movie: movie,
            view: vc,
            router: router,
            movieDetailsService: movieDetailsService
        )
        // better to add presenter disposable
        vc.setup(presenter: presenter)
        
        return vc
    }
    
}

