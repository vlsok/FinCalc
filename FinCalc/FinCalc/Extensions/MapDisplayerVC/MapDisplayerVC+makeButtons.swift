import UIKit
import CoreLocation
import YandexMapsMobile

extension MapDisplayerVC {
    func makeZoomInButton() {
        zoomInButton = UIButton(type: .custom)
        zoomInButton.frame = CGRect(x: view.bounds.width - buttonSize - 20, y: view.bounds.height / 2 - buttonSize - 10, width: buttonSize, height: buttonSize)
        
        styleSheet.makeMapButton(zoomInButton, view, "+", 10)

        zoomInButton.addTarget(self, action: #selector(zoomInButtonTapped), for: .touchUpInside)
        zoomInButton.addTarget(self, action: #selector(buttonHighlight(_:)), for: .touchDown)
        zoomInButton.addTarget(self, action: #selector(buttonUnhighlight(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    func makeZoomOutButton() {
        zoomOutButton = UIButton(type: .custom)
        zoomOutButton.frame = CGRect(x: view.bounds.width - buttonSize - 20, y: view.bounds.height / 2 + 10, width: buttonSize, height: buttonSize)

        styleSheet.makeMapButton(zoomOutButton, view, "–", 10)
        
        zoomOutButton.addTarget(self, action: #selector(zoomOutButtonTapped), for: .touchUpInside)
        zoomOutButton.addTarget(self, action: #selector(buttonHighlight(_:)), for: .touchDown)
        zoomOutButton.addTarget(self, action: #selector(buttonUnhighlight(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    func makeYaButton() {
        yaButton = UIButton(type: .custom)
        yaButton.translatesAutoresizingMaskIntoConstraints = false
        yaButton.frame = CGRect(x: view.bounds.width - buttonSize - 20, y: view.bounds.height / 2 + 30, width: buttonSize, height: buttonSize)

        styleSheet.makeMapButton(yaButton, view, "Я", buttonSize / 2)
        
        yaButton.addTarget(self, action: #selector(yaButtonTapped), for: .touchUpInside)
        yaButton.addTarget(self, action: #selector(buttonHighlight(_:)), for: .touchDown)
        yaButton.addTarget(self, action: #selector(buttonUnhighlight(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
}
