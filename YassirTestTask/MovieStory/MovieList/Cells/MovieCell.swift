import UIKit

final class MovieCell: UITableViewCell {
    
    static let identifier = String(describing: MovieCell.self)
    
    // MARK: - Views
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = Specs.insets.bottom
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        //imageView.image = Specs.posterPlaceHolder
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
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Private properties
    private enum Specs {
        static let backgroundColor: UIColor = .systemBackground
        static let titleFont: UIFont = .preferredFont(forTextStyle: .title2)
        static let insets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        static let posterSize = CGSize(width: 100, height: 150)
        static let posterPlaceHolder = UIImage(systemName: "photo")
        
        enum Accessibility {
            static let posterView = "posterView"
            static let nameLabel = "nameLabel"
            static let yearLabel = "yearLabel"
            static let voteLabel = "voteLabel"
            static let cellLabelPrefix = "MovieCell_"
        }
    }
    
    private let imageLoader: DataLoaderProtocol = ImageLoader()
    
    // MARK: - Init
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterView.image = Specs.posterPlaceHolder
        nameLabel.text = nil
        yearLabel.text = nil
        voteLabel.text = nil
        emptyLabel.text = nil
        accessibilityIdentifier = nil
    }
        
    // MARK: - Private methods
    private func setupUI() {
        backgroundColor = Specs.backgroundColor
        
        addSubview(posterView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(voteLabel)
        stackView.addArrangedSubview(yearLabel)
        stackView.addArrangedSubview(emptyLabel)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            posterView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Specs.insets.left),
            posterView.topAnchor.constraint(equalTo: self.topAnchor, constant: Specs.insets.top),
            posterView.widthAnchor.constraint(equalToConstant: Specs.posterSize.width),
            posterView.heightAnchor.constraint(equalToConstant: Specs.posterSize.height),
            
            stackView.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: Specs.insets.left),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Specs.insets.right),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: Specs.insets.top),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Specs.insets.bottom),
            stackView.heightAnchor.constraint(greaterThanOrEqualToConstant: Specs.posterSize.height)
        ])
    }

    // MARK: - Public methods
    func configure(for item: MovieCellViewModel) {
        nameLabel.text = item.title
        voteLabel.text = item.vote
        yearLabel.text = item.year
        
        imageLoader.loadImage(url: item.imageUrl) { [weak self] data in
            guard let data = data else { return }
            self?.posterView.image = UIImage(data: data)
        }
        
        accessibilityIdentifier = Specs.Accessibility.cellLabelPrefix + String(item.id)
    }

}
