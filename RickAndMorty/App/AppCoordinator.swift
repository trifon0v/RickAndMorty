import Foundation

final class AppCoordinator {
    
    private let appServices = AppServices()
    private let router: AppRouter
    
    init(router: AppRouter) {
        self.router = router
    }
    
    func start() {
        let charactersList = CharactersListBuilder.build(
            rickAndMortyService: appServices.rickAndMortyService,
            delegate: self
        )
        router.set(charactersList)
    }
}

extension AppCoordinator: CharactersListDelegate {

    func didPressOnCharacter(_ character: Character) {
        let controller = CharactersDetailBuilder.build(character: character)
        router.push(controller)
    }
}
