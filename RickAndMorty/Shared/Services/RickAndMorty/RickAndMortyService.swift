import Foundation

final class RickAndMortyService {
    
    private let networkClient: NetworkClient
    private var cachedResponse: CharactersListDTO?
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func fetchCharacters() async throws -> CharactersListDTO {
        if let cachedResponse {
            return cachedResponse
        }
        let response: CharactersListDTO = try await networkClient.request(RickAndMortyEndpoint.characters)
        self.cachedResponse = response
        return response
    }
}
