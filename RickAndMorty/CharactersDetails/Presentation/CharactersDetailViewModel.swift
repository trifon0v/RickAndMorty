import Combine
import Foundation

final class CharactersDetailViewModel {

    let character: AnyPublisher<Character, Never>
    
    init(character: Character) {
        self.character = Result.Publisher(character).eraseToAnyPublisher()
    }
}
