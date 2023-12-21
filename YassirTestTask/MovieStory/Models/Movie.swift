import Foundation

struct Movie: Codable {
    
    let id: Int
    let title: String
    let releaseDate: Date
    let posterPath: String
    let vote: Double
    let voteCount: Int

    // MARK: - Decodable
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case vote = "vote_average"
        case voteCount = "vote_count"
    }
}
