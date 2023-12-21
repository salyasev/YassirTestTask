import Foundation

// could be updated and used in future with other implementations of HttpClient (alamofire)
protocol HttpClientProtocol: AnyObject {
    
    var session: URLSession { get }
    
}

// Plus create service for auth:
// https://developer.themoviedb.org/reference/authentication-how-do-i-generate-a-session-id
// NOTE: may add extra checks and setup like ssl pinning, etc
final class HttpClient: HttpClientProtocol {
    
    // MARK: - HttpClientProtocol
    var session: URLSession
    
    // MARK: - Init
    init() {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
}
