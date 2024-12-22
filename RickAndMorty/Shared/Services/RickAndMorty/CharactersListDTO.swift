import Foundation

struct CharactersListDTO: Decodable {
    
    struct Info: Decodable {
        
        let count: Int
        let pages: Int
    }
    
    struct CharacterResult: Decodable {
        
        var id: Int
        let name: String
        let gender: String
        let image: URL
    }
    
    var info: Info
    var results: [CharacterResult]
}
