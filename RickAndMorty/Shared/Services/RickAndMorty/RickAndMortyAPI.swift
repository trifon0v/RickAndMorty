import Foundation

enum RickAndMortyEndpoint: EndpointBase {
    
    case characters
    
    var path: String {
        switch self {
        case .characters:
            return "/api/character"
        }
    }
    
    var base: String {
        "https://rickandmortyapi.com"
    }
}
