import UIKit

class CustomUISegmentedControl: UISegmentedControl {
    
    // inset amount
    private let segmentInset: CGFloat = 3.0
    
    // color initialization
    private var segmentImage: UIImage? = nil
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // font
        let font = UIFont(name: "Inter-Regular", size: 14.0)
        setTitleTextAttributes([NSAttributedString.Key.font: font as Any], for: .normal)
        
        // setting color
        if traitCollection.userInterfaceStyle == .light {
            segmentImage = UIImage(color: UIColor(named: "SelectedItem-Light")!)
        } else {
            segmentImage = UIImage(color: UIColor(named: "SelectedItem-Dark")!)
        }
        
        // background
        layer.cornerRadius = bounds.height / 2
        backgroundColor = UIColor(named: "UnselectedItem")
        
        // change sizes of UISegmentedControl
        frame = CGRect(x: CGFloat(Int(frame.origin.x)), y: frame.origin.y, width: frame.size.width, height: 40)
        
        // foreground
        let foregroundIndex = numberOfSegments
        
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView {
            
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            
            // substitute with colored image
            foregroundImageView.image = segmentImage
            
            // removes scaling animation
            foregroundImageView.layer.removeAnimation(forKey: "SelectionBounds")
            
            foregroundImageView.layer.masksToBounds = true
            
            foregroundImageView.layer.cornerRadius = foregroundImageView.bounds.height / 2
        }
        
    }
    
}
