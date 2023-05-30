import UIKit

extension UIView {
    
    @IBInspectable
    var cornerRadiusBottom: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            
            layer.cornerRadius = newValue
            layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
    }
    
    @IBInspectable
    var cornerRadiusFull: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            
            layer.cornerRadius = newValue
        }
    }
    
}
