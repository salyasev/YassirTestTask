import UIKit

final class MovieDatailsViewController: UIViewController, MovieDetailsViewInterface {

    // MARK: - Private properties
    private var presenter: MovieDetailsPresenterProtocol?
    private let imageLoader: DataLoaderProtocol = ImageLoader()
            
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.layoutMargins = Specs.insets
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    private lazy var posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = Specs.posterPlaceHolder
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.accessibilityIdentifier = Specs.Accessibility.posterView
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.accessibilityIdentifier = Specs.Accessibility.nameLabel
        label.font = Specs.titleFont
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = Specs.Accessibility.yearLabel
        label.font = Specs.subheadlineFont
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let voteLabel: UILabel = {
        let label = UILabel()
        label.accessibilityIdentifier = Specs.Accessibility.voteLabel
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.accessibilityIdentifier = Specs.Accessibility.taglineLabel
        label.font = Specs.footnoteFont
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.accessibilityIdentifier = Specs.Accessibility.overviewLabel
        label.font = Specs.bodyFont
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private enum Specs {
        static let backgroundColor: UIColor = .systemBackground
        static let titleFont: UIFont = .preferredFont(forTextStyle: .title1)
        static let footnoteFont: UIFont = .preferredFont(forTextStyle: .footnote)
        static let bodyFont: UIFont = .preferredFont(forTextStyle: .body)
        static let subheadlineFont: UIFont = .preferredFont(forTextStyle: .subheadline)
        
        static let posterHeight: CGFloat = 400
        static let posterPlaceHolder = UIImage(systemName: "photo")

        static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        enum Accessibility {
            static let view = "MovieDatailsViewController.view"
            static let posterView = "posterView"
            static let nameLabel = "nameLabel"
            static let yearLabel = "yearLabel"
            static let voteLabel = "voteLabel"
            static let taglineLabel = "taglineLabel"
            static let overviewLabel = "overviewLabel"
        }
    }
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        
        title = presenter?.title
        view.backgroundColor = Specs.backgroundColor
        
        view.accessibilityIdentifier = Specs.Accessibility.view
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(posterView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(taglineLabel)
        stackView.addArrangedSubview(voteLabel)
        stackView.addArrangedSubview(yearLabel)
        stackView.addArrangedSubview(overviewLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            posterView.heightAnchor.constraint(equalToConstant: Specs.posterHeight)
        ])
    }
    
    // MARK: - Public
    func setup(presenter: MovieDetailsPresenterProtocol) {
        self.presenter = presenter
    }
    
    // MARK: - MovieDetailsViewInterface
    func updateData(data: MovieDetailsViewData) {
        nameLabel.text = data.title
        voteLabel.text = data.vote
        yearLabel.text = data.year
        taglineLabel.text = data.tagline
        overviewLabel.text = data.overview
        
        imageLoader.loadImage(url: data.imageUrl) { [weak self] data in
            guard let self = self,
                  let data = data else { return }
            self.posterView.image = UIImage(data: data)
        }
    }
}
