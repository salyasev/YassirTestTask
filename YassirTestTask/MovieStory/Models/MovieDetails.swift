import Foundation

struct MovieDetails: Codable {
    
    let id: Int
    let title: String
    let releaseDate: Date
    let posterPath: String
    let vote: Double
    let voteCount: Int
    let overview: String
    let tagline: String

    // MARK: - Decodable
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case vote = "vote_average"
        case voteCount = "vote_count"
        case overview
        case tagline
    }
    
}
