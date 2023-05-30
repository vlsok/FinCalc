import UIKit

extension UIViewController {
    func updateResultLabel(_ resultLabel: UILabel, with result: String, in scrollView: UIScrollView) {
        DispatchQueue.main.async {
            resultLabel.numberOfLines = 0
            resultLabel.lineBreakMode = .byWordWrapping
            
            resultLabel.text = result
            
            let labelWidth = scrollView.bounds.width - (2 * scrollView.contentInset.left)
            let labelSize = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
            let requiredLabelSize = resultLabel.sizeThatFits(labelSize)

            resultLabel.frame = CGRect(x: scrollView.contentInset.left,
                                       y: 0,
                                       width: labelWidth,
                                       height: requiredLabelSize.height)
        }
    }
}


