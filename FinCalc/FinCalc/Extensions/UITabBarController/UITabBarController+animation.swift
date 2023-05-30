import UIKit

extension CustomUITabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            guard let fromView = selectedViewController?.view, let toView = viewController.view else {
                return false
            }

            if fromView != toView {
                UIView.transition(from: fromView, to: toView, duration: 0.4, options: [.transitionCrossDissolve], completion: nil)
            }

            return true
    }
}
