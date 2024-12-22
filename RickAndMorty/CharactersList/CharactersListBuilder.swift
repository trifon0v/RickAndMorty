import Foundation
import UIKit

struct CharactersListBuilder {
    
    static func build(
        rickAndMortyService: RickAndMortyService,
        delegate: CharactersListDelegate
    ) -> UIViewController {
        let viewModel = CharactersListViewModelImpl(rickyAndMortyService: rickAndMortyService, delegate: delegate)
        let controller = CharactersListViewController(viewModel)
        return controller
    }
}
