import Foundation
import Combine

protocol CharactersListViewModel {
    
    var viewState: AnyPublisher<ViewState<[Character]>, Never> { get }
    
    func viewDidLoad()
    func didPressOnCharacter(_ character: Character)
}

protocol CharactersListDelegate: AnyObject {
    
    func didPressOnCharacter(_ character: Character)
}

final class CharactersListViewModelImpl: CharactersListViewModel {
    
    private var internalViewState: CurrentValueSubject<ViewState<[Character]>, Never> = .init(.idle)
    private let rickyAndMortyService: RickAndMortyService
    private weak var delegate: CharactersListDelegate?
    private var cachedResponse: CharactersListDTO?
    
    init(
        rickyAndMortyService: RickAndMortyService,
        delegate: CharactersListDelegate?
    ) {
        self.rickyAndMortyService = rickyAndMortyService
        self.delegate = delegate
    }
    
    var viewState: AnyPublisher<ViewState<[Character]>, Never> {
        internalViewState.eraseToAnyPublisher()
    }
    
    func viewDidLoad() {
        internalViewState.send(.loading)
        Task {
            do {
                let response = try await rickyAndMortyService.fetchCharacters()
                self.cachedResponse = response
                internalViewState.send(.loaded(response.asDomain))
            } catch {
                internalViewState.send(.error)
            }
        }
    }
    
    func didPressOnCharacter(_ character: Character) {
        delegate?.didPressOnCharacter(character)
    }
}

private extension CharactersListDTO {
    
    var asDomain: [Character] {
        self.results.map { .init(id: $0.id, name: $0.name, image: $0.image) }
    }
}
