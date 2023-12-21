import XCTest
@testable import YassirTestTask

final class HttpClientMock: HttpClientProtocol {
    
    var session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
}
