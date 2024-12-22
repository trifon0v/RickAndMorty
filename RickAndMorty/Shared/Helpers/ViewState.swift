import Foundation

enum ViewState<Loaded> {
    
    case idle
    case loading
    case loaded(Loaded)
    case error
}
