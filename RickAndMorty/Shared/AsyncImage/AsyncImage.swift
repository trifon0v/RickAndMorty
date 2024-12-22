import Foundation
import UIKit
import Combine

class AsyncImageView: UIImageView {
    
    private var cancellable: AnyCancellable?
    private var imageProvider = ImageProvider.shared
    
    var url: URL? {
        didSet {
            cancelCurrent()
        }
    }
    
    func loadImage() {
        if let url {
            cancellable = imageProvider
                .getImage(url)
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] image in
                    self?.image = image
                    self?.invalidateIntrinsicContentSize()
                })
        }
    }
    
    func cancelCurrent() {
        cancellable?.cancel()
        cancellable = nil
    }
    
}
