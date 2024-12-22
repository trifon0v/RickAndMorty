final class AppServices {
    
    init() {}
        
    lazy var networkClient = NetworkClient()
    lazy var rickAndMortyService = RickAndMortyService(networkClient: networkClient)
}
