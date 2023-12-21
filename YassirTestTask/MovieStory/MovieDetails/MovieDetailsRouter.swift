import Foundation
import UIKit

protocol MovieDetailsRouterProtocol: AnyObject {
    
    func showError(text: String)
    
}

final class MovieDetailsRouter: MovieDetailsRouterProtocol {
    
    // MARK: - Private
    private weak var viewController: UIViewController?
    
    // MARK: - Init
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    // MARK: - MovieListRouterProtocol
    func showError(text: String) {
        let alert = UIAlertController(title: "Error!", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        viewController?.present(alert, animated: true)
    }
    
}
