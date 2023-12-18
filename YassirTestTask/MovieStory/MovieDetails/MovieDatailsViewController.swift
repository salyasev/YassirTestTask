import UIKit

final class MovieDatailsViewController: UIViewController {
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        label.text = "TEST DETAILS"
        label.frame = view.bounds
        label.textAlignment = .center
        view.addSubview(label)
    }
    
}
