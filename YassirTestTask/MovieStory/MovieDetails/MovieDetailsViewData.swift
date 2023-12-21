import Foundation

final class MovieDetailsViewData {
    
    let id: Int
    let title: String
    let year: String
    let vote: String
    let imageUrl: URL?
    let overview: String?
    let tagline: String?
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    
    // MARK: - Init
    init(movieDetails: MovieDetails) {
        self.id = movieDetails.id
        self.title = movieDetails.title
        self.year = "Release date: \(dateFormatter.string(from: movieDetails.releaseDate))"
        self.vote = "Score: \(movieDetails.vote) (\(movieDetails.voteCount))"
        self.imageUrl = URL(string: "\(Constants.Image.baseUrl)\(Constants.Image.originalSize)\(movieDetails.posterPath)")
        self.overview = movieDetails.overview
        self.tagline = movieDetails.tagline
    }
    
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title
        self.year = "Release date: \(dateFormatter.string(from: movie.releaseDate))"
        self.vote = "Score: \(movie.vote) (\(movie.voteCount))"
        self.imageUrl = URL(string: "\(Constants.Image.baseUrl)\(Constants.Image.originalSize)\(movie.posterPath)")
        self.overview = nil
        self.tagline = nil
    }
    
}

