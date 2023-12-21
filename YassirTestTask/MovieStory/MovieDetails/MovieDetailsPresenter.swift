import Foundation

protocol MovieDetailsPresenterProtocol: AnyObject {

    var title: String { get }
    
}

final class MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    
    // MARK: - MovieDetailsPresenterProtocol
    var title: String = "Details"
    
    // MARK: - Private properties
    private weak var view: MovieDetailsViewInterface?

    private let movie: Movie
    private let router: MovieDetailsRouterProtocol
    private let movieDetailsService: MovieDetailsServiceProtocol
    
    private var movieDetails: MovieDetails?
    
    // MARK: - Init
    init(
        movie: Movie,
        view: MovieDetailsViewInterface?,
        router: MovieDetailsRouterProtocol,
        movieDetailsService: MovieDetailsServiceProtocol)
    {
        self.movie = movie
        self.view = view
        self.router = router
        self.movieDetailsService = movieDetailsService
        
        reuseDataFromPreviousScreen()
        loadData()
    }
    
    // MARK: - Private methods
    private func reuseDataFromPreviousScreen() {
        // using data from previous screen first to show what we have before start loading
        let viewData = MovieDetailsViewData(movie: movie)
        view?.updateData(data: viewData)
    }
    
    private func loadData() {
        movieDetailsService.loadMovieDetails(id: movie.id) { [weak self] result in
            switch result {
            case .success(let movieDetails):
                self?.movieDetails = movieDetails
                
                let viewData = MovieDetailsViewData(movieDetails: movieDetails)
                DispatchQueue.main.async {
                    self?.view?.updateData(data: viewData)
                }
                
            case .failure(let error):
                // TODO: add business logic here (for example retry login)
                DispatchQueue.main.async {
                    self?.router.showError(text: error.errorDescription)
                }
            }
        }
    }
    
}
        
