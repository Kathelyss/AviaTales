import UIKit

protocol Presentable: class {

    func toPresent() -> UIViewController
}

extension Presentable where Self: UIViewController {

    func toPresent() -> UIViewController {
        self
    }
}
