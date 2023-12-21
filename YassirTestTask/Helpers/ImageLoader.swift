import Foundation

protocol DataLoaderProtocol {
    
    func loadImage(url: URL?, completion: @escaping (Data?)->())
    
}

// TODO: in future use some skd for loading and caching images like Kingfisher
final class ImageLoader: DataLoaderProtocol {
    
    // MARK: - DataLoaderProtocol
    func loadImage(url: URL?, completion: @escaping (Data?)->()) {
        guard let imageURL = url else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let error = error {
                print("Error getting data: \(String(describing: error))")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }.resume()
    }
    
}
