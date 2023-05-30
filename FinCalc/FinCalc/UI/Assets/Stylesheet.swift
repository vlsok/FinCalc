import UIKit

struct StyleSheet {
    func setButtonStyle(_ button: UIButton, _ attributedText: NSMutableAttributedString) {
        button.layer.borderColor = UIColor(named: "UIButton-borderColor")?.cgColor
        button.layer.borderWidth = 0.5
        
        if button.isSelected {
            button.tintColor = UIColor(named: "UIButton-selected")
            attributedText.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedText.length))
            button.setAttributedTitle(attributedText, for: .normal)
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                button.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            }, completion: { _ in
                UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
                    button.transform = CGAffineTransform.identity
                })
            })
        } else {
            button.tintColor = UIColor(named: "UIButton-unselected")
            attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 0, length: attributedText.length))
            button.setAttributedTitle(attributedText, for: .normal)
        }
    }
    
    func animateBorder(for view: UIView?, isAdding: Bool) {
        guard let view = view else { return }
        
        let duration = 0.2
        
        let borderColor: CGColor
        if isAdding {
            borderColor = UIColor(named: "UIButton-borderColor")!.cgColor
        } else {
            borderColor = view.layer.borderColor ?? UIColor.clear.cgColor
        }
        
        let borderWidthAnimation = CABasicAnimation(keyPath: "borderWidth")
        borderWidthAnimation.fromValue = isAdding ? 0 : view.layer.borderWidth
        borderWidthAnimation.toValue = isAdding ? 1 : 0
        
        let borderColorAnimation = CABasicAnimation(keyPath: "borderColor")
        borderColorAnimation.fromValue = isAdding ? UIColor.clear.cgColor : view.layer.borderColor
        borderColorAnimation.toValue = borderColor
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.duration = duration
        groupAnimation.animations = [borderWidthAnimation, borderColorAnimation]
        
        view.layer.borderWidth = isAdding ? 1 : 0
        view.layer.borderColor = borderColor
        view.layer.add(groupAnimation, forKey: "border")
    }
    
    func checkModeForTextField(_ textFiled: UITextField) {
        if UITraitCollection.current.userInterfaceStyle == .light {
            textFiled.tintColor = .black
        } else {
            textFiled.tintColor = .white
        }
    }
    
    func updateButtonSelectionStates(_ firstButton: UIButton, _ secondButton: UIButton, _ isFirstSelected: Bool, _ isSecondSelected: Bool) {
        firstButton.isSelected = isFirstSelected
        secondButton.isSelected = isSecondSelected
        
        setButtonStyle(firstButton, NSMutableAttributedString("Выделить"))
        setButtonStyle(secondButton, NSMutableAttributedString("Начислить"))
    }
    
    func makeMapButton(_ button: UIButton, _ view: UIView, _ title: String, _ cornerRadius: CGFloat) {
        button.translatesAutoresizingMaskIntoConstraints = false

        button.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        
        button.layer.cornerRadius = cornerRadius
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.minimumScaleFactor = 1
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        
        button.contentHorizontalAlignment = .center
        button.contentVerticalAlignment = .center
    }
    
    func updateRefreshControlTintColor(_ refreshControl: UIRefreshControl) {
        if UITraitCollection.current.userInterfaceStyle == .light {
            refreshControl.tintColor = .black
        } else {
            refreshControl.tintColor = .white
        }
    }
    
    func addTopInsetView(_ scrollView: UIScrollView) {
        let topInsetView = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: 100))
        scrollView.addSubview(topInsetView)
        scrollView.sendSubviewToBack(topInsetView)
        
        let offset = topInsetView.frame.size.height
        scrollView.contentInset.top = offset
        scrollView.verticalScrollIndicatorInsets.top = offset
    }
}


