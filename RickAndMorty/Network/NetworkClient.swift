import Foundation

final class NetworkClient {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    func request<Response: Decodable>(_ endpoint: EndpointBase) async throws -> Response {
        let (data, _) = try await session.data(for: endpoint.makeRequest())
        return try decoder.decode(Response.self, from: data)
    }
}
