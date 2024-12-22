import Foundation
import UIKit
import Combine

final class CharactersDetailViewController: UIViewController {
    
    private let viewModel: CharactersDetailViewModel
    private let contentView = CharactersDetailView()
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: CharactersDetailViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentView)
        view.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        observeState()
    }
    
    private func observeState() {
        viewModel
            .character
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] character in
                self?.contentView.render(CharactersDetailView.Props(characterName: character.name, imageURL: character.image))
            })
            .store(in: &cancellables)
    }
}
