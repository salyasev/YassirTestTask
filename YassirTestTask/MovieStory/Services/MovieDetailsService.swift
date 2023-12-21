import Foundation

protocol MovieDetailsServiceProtocol: AnyObject {
    
    func loadMovieDetails(id: Int, completion: @escaping (Result<MovieDetails, ApiError>) -> Void)
    
}

// API Docs: https://developer.themoviedb.org/reference/movie-details
// TODO: talk with backend side about data contract to simplify it and remove unnessesary data from API
final class MovieDetailsService: MovieDetailsServiceProtocol {
   
    private let path = "movie"
    
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
    
    // MARK: - MovieDatailsServiceProtocol
    func loadMovieDetails(id: Int, completion: @escaping (Result<MovieDetails, ApiError>) -> Void) {
        guard let url = buildURL(movieId: id) else {
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
            
            if let response = try? decoder.decode(MovieDetails.self, from: data) {
                completion(.success(response))
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
        }.resume()
    }
    
    // MARK: - Private
    private func buildURL(movieId: Int) -> URL? {
        var components = URLComponents()
        components.scheme = Constants.Api.scheme
        components.host = Constants.Api.host
        components.path = Constants.Api.version + path + "/" + String(movieId)
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.Api.key)
        ]
        
        return components.url
    }
}
