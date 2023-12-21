import Foundation

final class MovieCellViewModel {
    
    let id: Int
    let title: String
    let year: String
    let vote: String
    let imageUrl: URL?
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter
    }()
    
    // MARK: - Init
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.year = dateFormatter.string(from: movie.releaseDate)
        self.vote = "Score: \(movie.vote) (\(movie.voteCount))"
        self.imageUrl = URL(string: "\(Constants.Image.baseUrl)\(Constants.Image.thumbnailSize)\(movie.posterPath)")
    }
    
}

