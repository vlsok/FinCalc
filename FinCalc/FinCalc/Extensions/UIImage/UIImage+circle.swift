import UIKit

extension UIImage {
    static func circle(radius: CGFloat, color: UIColor) -> UIImage {
        let diameter = radius * 2
        let size = CGSize(width: diameter, height: diameter)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        let context = UIGraphicsGetCurrentContext()
        let rectangle = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        
        context?.setFillColor(color.cgColor)
        context?.fillEllipse(in: rectangle)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
}
