import Foundation
import UIKit

struct CharactersDetailBuilder {
    
    static func build(
        character: Character
    ) -> UIViewController {
        let viewModel = CharactersDetailViewModel(character: character)
        let controller = CharactersDetailViewController(viewModel: viewModel)
        return controller
    }
}
