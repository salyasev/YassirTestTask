import Foundation

protocol MovieListServiceProtocol: AnyObject {
    
    func loadMovies(page: Int, completion: @escaping (Result<[Movie], ApiError>) -> Void)
    
}

// API Docs: https://developer.themoviedb.org/reference/discover-movie
// TODO: talk with backend side about data contract to simplify it and remove unnessesary data from API
final class MovieListService: MovieListServiceProtocol {
 
    private let path = "discover/movie"
    
    private let httpClient: HttpClientProtocol
    
    internal let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
        
    // MARK: - Init
    init(httpClient: HttpClientProtocol) {
        self.httpClient = httpClient
    }
    
    // MARK: - UserListServiceProtocol
    func loadMovies(page: Int, completion: @escaping (Result<[Movie], ApiError>) -> Void) {
        
        // NOTE: - do not want customise count & filtering for now.
        guard let url = buildURL(page: page) else {
            completion(.failure(.clientSide))
            return
        }
  
        httpClient.session.dataTask(with: url) { [dateFormatter] (data, response, error)  in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.serverSide("Something has gone wrong. Please try again later.")))
                return
            }
            
            guard let data = data else {
                completion(.failure(.serverSide("Something has gone wrong. Please try again later.")))
                return
            }
 
            // NOTE: uncomment for testing:
//            if let dataString = String(data: data, encoding: .utf8) {
//                print("Received data: \(dataString)")
//            }
            
            let decoder =  JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            if let response = try? decoder.decode(MovieList.self, from: data) {
                completion(.success(response.results))
                return
            } else {
                if let response = try? JSONDecoder().decode(ApiErrorResponse.self, from: data) {
                    // TODO: Improve error handling, check status, code and update logic
                    // https://developer.themoviedb.org/docs/errors
                    completion(.failure(.serverSide(response.message)))
                    return
                } else {
                    completion(.failure(.decoding))
                    return
                }
            }
        }.resume() // TODO: in future add task management, like to cancel an ongoing request (no needed for now)
    }
    
    // MARK: - Private
    private func buildURL(page: Int) -> URL? {
        var components = URLComponents()
        components.scheme = Constants.Api.scheme
        components.host = Constants.Api.host
        components.path = Constants.Api.version + path
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "api_key", value: Constants.Api.key)
            // add other filtering
        ]
        
        return components.url
    }
    
}
