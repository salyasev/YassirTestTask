enum Constants {
    
    enum Api {
        static let scheme   = "https"
        static let host     = "api.themoviedb.org"
        static let version  = "/3/"
        
        // TODO: move to keychain and use for create session only
        // https://developer.themoviedb.org/reference/authentication-how-do-i-generate-a-session-id
        static let key  = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    }
    
    enum Image {
        static let baseUrl = "https://image.tmdb.org/t/p/"
        static let originalSize = "original"
        static let thumbnailSize = "w500"
    }
    
}
