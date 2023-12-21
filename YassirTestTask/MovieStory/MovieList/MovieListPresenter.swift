import Foundation

protocol MovieListPresenterProtocol: AnyObject {

    var title: String { get }
    var cellItems: [MovieCellViewModel] { get }
    
    func didSelectMovieCell(index: Int)
    func loadMoreDataIfNeeded(index: Int)
    
}

final class MovieListPresenter: MovieListPresenterProtocol {
    
    // MARK: - MovieListPresenterProtocol
    var title: String = "Movies"
    var cellItems: [MovieCellViewModel] = []
    
    // MARK: - Private properties
    private weak var view: MovieListViewInterface?

    private let router: MovieListRouterProtocol
    private let movieListService: MovieListServiceProtocol
    
    // TODO: implementation of interactor if needed + presistent storage logic
    // private let movieListInteractor: MovieListInteractorProtocol
    
    internal var movies: [Movie] = []
    private var currentPage = 0
    
    // MARK: - Init
    init(
        view: MovieListViewInterface?,
        router: MovieListRouterProtocol,
        movieListService: MovieListServiceProtocol)
    {
        self.view = view
        self.router = router
        self.movieListService = movieListService
        
        loadData()
    }
    
    // MARK: - Private methods
    private func loadData() {
        currentPage += 1
        // NOTE: uncomment for testing:
        //print("start loading page: \(currentPage)")
        movieListService.loadMovies(page: currentPage) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movies.append(contentsOf: movies)
            
                let cellItems = movies.map {
                    // NOTE: uncomment for testing:
                    //print("name: \($0.title)")
                    return MovieCellViewModel(movie: $0)
                }
                self?.cellItems.append(contentsOf: cellItems)
                
                // depends on code style.
                // should be a clear contract between service layer and domain layer.
                // also we may pass return queue as parameter for example
                DispatchQueue.main.async {
                    self?.view?.updateData()
                }
                
            case .failure(let error):
                // TODO: add business logic here (for example retry login)
                DispatchQueue.main.async {
                    self?.router.showError(text: error.errorDescription)
                }
            }
        }
    }
    
    // MARK: - MovieListPresenterProtocol
    func didSelectMovieCell(index: Int) {
        guard let movie = movies[safeIndex: index] else { return }
        router.showMovieDetails(movie: movie)
    }
    
    func loadMoreDataIfNeeded(index: Int) {
        let count = cellItems.count
        let prefetchIndex = 1
        
        // add extra checks and logic here if needed
        if index == count - prefetchIndex {
            loadData()
        }
    }
}
        
