import UIKit

final class SearchRouter: BaseRouter {

    let navigationController: UINavigationController
    private let factory: AppFactory

    init(navigationController: UINavigationController, factory: AppFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }

    func start() {
        navigationController.viewControllers = [factory.makeSearchViewController()]
    }
}
