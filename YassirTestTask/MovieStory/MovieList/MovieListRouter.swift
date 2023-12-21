import Foundation
import UIKit

protocol MovieListRouterProtocol: AnyObject {
    
    func showMovieDetails(movie: Movie)
    func showError(text: String)
    
}

final class MovieListRouter: MovieListRouterProtocol {
    
    // MARK: - Private
    private weak var viewController: UIViewController?
    private weak var scenarioBuilder: MovieStoryScenarioBuilderProtocol?
    
    // MARK: - Init
    init(
        viewController: UIViewController?,
        scenarioBuilder: MovieStoryScenarioBuilderProtocol?)
    {
        self.viewController = viewController
        self.scenarioBuilder = scenarioBuilder
    }
    
    // MARK: - MovieListRouterProtocol
    func showMovieDetails(movie: Movie) {
        if let vc = scenarioBuilder?.makeMovieDetailsViewController(movie: movie) {
            viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showError(text: String) {
        let alert = UIAlertController(title: "Error!", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController?.present(alert, animated: true)
    }
    
}
