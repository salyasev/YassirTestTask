import UIKit

final class MovieListViewController: UIViewController,
                                     UITableViewDataSource,
                                     UITableViewDelegate,
                                     MovieListViewInterface
{
    // MARK: - Private properties
    private var presenter: MovieListPresenterProtocol?
    
    private let tableView = UITableView()
    
    private enum Specs {
        static let backgroundColor: UIColor = .systemBackground
        static let estimatedRowHeight: CGFloat = 150
        
        enum Accessibility {
            static let view = "MovieListViewController.view"
            static let tableView = "MovieListViewController.tableView"
        }
    }
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()

        title = presenter?.title
        view.backgroundColor = Specs.backgroundColor
        view.accessibilityIdentifier = Specs.Accessibility.view
                
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
        
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.estimatedRowHeight = Specs.estimatedRowHeight
        tableView.rowHeight = UITableView.automaticDimension
        tableView.accessibilityIdentifier = Specs.Accessibility.tableView
        view.addSubview(tableView)
    }
    
    // MARK: - Public
    func setup(presenter: MovieListPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - MovieListViewInterface
    func updateData() {
        // if needed we could pass also the loading state and show indicatiors
        // better to do batch updates or by cells
        tableView.reloadData()
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.cellItems.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath)
        guard let movieCell = cell as? MovieCell else {
            print("Issue with cell identifier")
            // or 
            // fatalError("Should have a cell and associated view model")
            // it depends on effect we would like, but prefer do not crash app in any case
            return cell
        }
        
        if let cellViewModel = presenter?.cellItems[safeIndex: indexPath.row] {
            movieCell.configure(for: cellViewModel)
        }
        
        return movieCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // if needed we could pass also the loading state and show indicatiors
        presenter?.loadMoreDataIfNeeded(index: indexPath.row)
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter?.didSelectMovieCell(index: indexPath.row)
    }
}
