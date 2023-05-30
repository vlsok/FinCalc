import UIKit

extension UIViewController {
    var containedScrollView: UIScrollView? {
        return view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView
    }
    
    var containedTextFields: [UITextField]? {
        return view.subviews.compactMap { $0 as? UITextField }
    }
    
    @objc
    func keyboardWillChangeFrame(notification: Notification) {
        guard let scrollView = containedScrollView, let textFields = containedTextFields, let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }

        let keyboardFrameInView = view.convert(keyboardFrame, from: nil)
        let intersection = scrollView.frame.intersection(keyboardFrameInView)

        if intersection.height > 0 {
            scrollView.contentInset = UIEdgeInsets(top: 100.0, left: 0.0, bottom: intersection.height + 10.0, right: 0.0)

            if let firstResponder = textFields.first(where: { $0.isFirstResponder }) {
                var rect = firstResponder.convert(firstResponder.bounds, to: scrollView)
                rect = rect.insetBy(dx: 0, dy: -10)
                scrollView.scrollRectToVisible(rect, animated: true)
            }
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 100.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
    }
}
