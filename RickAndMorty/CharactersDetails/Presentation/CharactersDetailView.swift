import Foundation
import UIKit

final class CharactersDetailView: UIView {
    
    struct Props {
        
        let characterName: String
        let imageURL: URL
    }
    
    private let label = UILabel()
    private let imageView = AsyncImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(_ props: Props) {
        self.label.text = props.characterName
        self.imageView.url = props.imageURL
        imageView.loadImage()
    }
    
    private func configureView() {
        addSubview(label)
        addSubview(imageView)
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 20),
        ])
    }
}
