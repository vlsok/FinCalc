import UIKit

extension UIButton {
    func addShadow() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        layer.shadowRadius = 4.0
        layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        layer.shadowOpacity = 1.0
    }
    
    func removeShadow() {
        layer.shadowColor = nil
        layer.shadowRadius = 0.0
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.0
    }
    
    @IBInspectable
    var hasShadow: Bool {
        get {
            layer.shadowColor != nil
        }
        set {
            if newValue {
                addShadow()
            } else {
                removeShadow()
            }
        }
    }
    
}
