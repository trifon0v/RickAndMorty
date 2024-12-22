import Foundation

protocol EndpointBase {
 
    var base: String { get }
    var path: String { get }
}

extension EndpointBase {
    
    func makeRequest() -> URLRequest {
        let url = URL(string: self.base + self.path)!
        let request = URLRequest(url: url)
        return request
    }
}
