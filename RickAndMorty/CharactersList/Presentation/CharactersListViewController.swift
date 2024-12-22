import Foundation
import UIKit
import Combine

final class CharactersListViewController: UIViewController {
    
    private let viewModel: CharactersListViewModel
    private var cancellable: AnyCancellable?
    
    private let charactersListView = CharactersListView()
    private var items: [Character] = []
    
    init(_ viewModel: CharactersListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        observeState()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(charactersListView)
        charactersListView.tableView.delegate = self
        charactersListView.tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        charactersListView.frame = view.bounds
    }
    
    private func observeState() {
        cancellable = viewModel.viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self else { return }
                switch state {
                case .idle:
                    break
                case .loading:
                    charactersListView.focusOnLoadingView()
                case .loaded(let loaded):
                    charactersListView.focusOnTableView()
                    items = loaded
                    charactersListView.tableView.reloadData()
                case .error:
                    charactersListView.focusOnErrorView()
                    charactersListView.errorLabel.text = "Error happened during loading"
                }
        }
    }
}

extension CharactersListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didPressOnCharacter(items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let characterCell = cell as? CharactersListTableViewCell else { return }
        characterCell.cellWillAppear()
    }
}

extension CharactersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CharactersListTableViewCell.identifier,
            for: indexPath
        ) as? CharactersListTableViewCell else {
            return CharactersListTableViewCell()
        }
        let character = items[indexPath.row]
        cell.configure(with: character)
        return cell
    }
}
