import Foundation
import UIKit

final class CharactersListView: UIView {

    lazy var tableView = UITableView()
    
    lazy var loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "An error occurred"
        label.textAlignment = .center
        label.textColor = .systemRed
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func focusOnErrorView() {
        tableView.isHidden = true
        errorLabel.isHidden = false
        loadingView.stopAnimating()
    }
    
    func focusOnTableView() {
        tableView.isHidden = false
        errorLabel.isHidden = true
        loadingView.stopAnimating()
    }
    
    func focusOnLoadingView() {
        tableView.isHidden = true
        errorLabel.isHidden = true
        loadingView.isHidden = false
        loadingView.startAnimating()
    }
    
    private func setupView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(CharactersListTableViewCell.self, forCellReuseIdentifier: CharactersListTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        addSubview(tableView)
        addSubview(loadingView)
        addSubview(errorLabel)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            loadingView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            errorLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])

        focusOnLoadingView()
    }
}
