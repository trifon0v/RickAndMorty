import Foundation
import Combine
import UIKit

final class ImageProvider {
    
    static let shared = ImageProvider()
    
    private init() { }

    private var cache = NSCache<NSURL, UIImage>()
    private let session = URLSession(configuration: .default)
    
    func getImage(_ url: URL) -> AnyPublisher<UIImage?, Never> {
        let nsURL = url as NSURL
        if let image = cache.object(forKey: nsURL) {
            return Result.Publisher(.success(image)).eraseToAnyPublisher()
        }
        return session
            .dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { [weak self] image in
                if let image {
                    self?.cache.setObject(image, forKey: nsURL)
                }
        }) .eraseToAnyPublisher()
    }
}
