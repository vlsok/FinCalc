import UIKit

class CustomUITabBar: UITabBar {
    
    @IBInspectable
    var height: CGFloat = 0.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        guard let window = UIApplication.shared.connectedScenes
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        else {
            return super.sizeThatFits(size)
        }
        
        var sizeThatFits = super.sizeThatFits(size)
        
        if height > 0.0 {
            if #available(iOS 12.0, *) {
                sizeThatFits.height = height + window.safeAreaInsets.bottom
            } else {
                sizeThatFits.height = height
            }
        }
        
        return sizeThatFits
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        setTabBarAppearance()
    }
    
    private func setup() {
        layer.masksToBounds = true
        layer.cornerRadius = 30
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        isTranslucent = true

        setTabBarAppearance()
    }
    
    private func setTabBarAppearance() {
        let appearance = UITabBarAppearance()
        let itemAppearance = UITabBarItemAppearance()
        
        appearance.backgroundColor = UIColor(named: "UITabBar")
        
        if #available(iOS 12.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .light {
                itemAppearance.normal.iconColor = .black
                itemAppearance.selected.iconColor = .white
                selectionIndicatorImage = UIImage(named: "Background-Light")?.scalePreservingAspectRatio(targetSize: CGSize(width: 50, height: 50))
            } else {
                itemAppearance.normal.iconColor = .white
                itemAppearance.selected.iconColor = .black
                selectionIndicatorImage = UIImage(named: "Background-Dark")?.scalePreservingAspectRatio(targetSize: CGSize(width: 50, height: 50))
            }
        } else {
            //
        }
        
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance

        scrollEdgeAppearance = appearance
        standardAppearance = appearance
    }
    
    
    
}
