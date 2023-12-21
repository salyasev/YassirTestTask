import Foundation

enum ApiError: Error, Equatable, LocalizedError {
    
    case clientSide
    case decoding
    case serverSide(String)
    
    // MARK: - LocalizedError
    var errorDescription: String {
        switch self {
        case .clientSide, .decoding:
            return "Something has gone wrong. Please update the app."
        case .serverSide(let text):
            // from BE side should be provided understandable user errors (not technical)
            return text
        }
    }
}

// https://developer.themoviedb.org/docs/errors
// Need to improve error handling, check status, code and update logic
struct ApiErrorResponse: Codable {
    
    let success: Bool
    let code: Int
    let message: String
    
    // MARK: - Decodable
    enum CodingKeys: String, CodingKey {
        case success
        case code = "status_code"
        case message = "status_message"
    }
    
}

