import UIKit

final class MovieListViewController: UIViewController {

    private let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        label.text = "TEST LIST"
        label.frame = view.bounds
        label.textAlignment = .center
        view.addSubview(label)
    }


}

