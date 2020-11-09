import UIKit

final class ApplicationCoordinator {

    private let moduleFactory = ModuleFactory()
    
    let window: UIWindow
    let navigationcontroller = UINavigationController()

    init() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
    }

    func start() {
        window.rootViewController = navigationcontroller
        window.makeKeyAndVisible()
        showDestinationPickerModule()
    }

    // MARK: - Modules

    func showDestinationPickerModule() {
        let module = moduleFactory.createDestinationPickerModule()

        module.onShowRoute = { [weak self] destination in
            self?.showMapModule(with: destination)
        }

        navigationcontroller.viewControllers.append(module.toPresent())
    }

    func showMapModule(with destination: AirportModel) {
        let module = moduleFactory.createMapModule(with: destination)

        navigationcontroller.pushViewController(module.toPresent(), animated: true)
    }
}
