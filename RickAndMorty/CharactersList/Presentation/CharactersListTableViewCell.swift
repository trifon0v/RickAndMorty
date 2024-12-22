import Foundation
import UIKit

final class CharactersListTableViewCell: UITableViewCell {
    
    static let identifier = "CharactersListTableViewCell"

    // MARK: Private
    
    private lazy var asyncImage = AsyncImageView()
    private lazy var nameLabel = UILabel()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Public methods
    
    func cellWillAppear() {
        asyncImage.loadImage()
    }
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        asyncImage.url = character.image
    }
    
    private func setupView() {
        asyncImage.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 0
        contentView.addSubview(asyncImage)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            asyncImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            asyncImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            asyncImage.widthAnchor.constraint(equalToConstant: 100),
            asyncImage.heightAnchor.constraint(equalToConstant: 100),
            asyncImage.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
            
            nameLabel.centerYAnchor.constraint(equalTo: asyncImage.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: asyncImage.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        asyncImage.cancelCurrent()
        asyncImage.image = nil
        nameLabel.text = nil
    }
}
