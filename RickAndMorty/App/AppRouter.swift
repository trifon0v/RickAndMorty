import UIKit

final class AppRouter {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func push(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func set(_ viewController: UIViewController) {
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
