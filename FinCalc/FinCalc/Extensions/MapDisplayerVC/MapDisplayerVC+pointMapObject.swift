import UIKit
import CoreLocation
import YandexMapsMobile

extension MapDisplayerVC {
    func makePointMapObject(_ radius: CGFloat, _ color: UIColor, _ latitude: Double, _ longtitude: Double, _ tag: String) {
        
        var pointMapObject: YMKPlacemarkMapObject!
        
        let circleImage = UIImage.circle(radius: radius, color: color)

        let point = YMKPoint(latitude: latitude, longitude: longtitude)
        pointMapObject = mapView.mapWindow.map.mapObjects.addPlacemark(with: point)
        pointMapObject.setIconWith(circleImage)
        
        mapObjectTags[pointMapObject] = tag
        
        pointMapObject.addTapListener(with: self)
    }
    
    func makeDescription(_ mapObject: YMKMapObject) -> String {
        var description = ""
        
        if let placemarkMapObject = mapObject as? YMKPlacemarkMapObject,
           let tag = mapObjectTags[placemarkMapObject] {
            if tag == "FirstPoint" {
                description = "БСБ-Банк"
            } else if tag == "SecondPoint" {
                description = "СБЕР-Банк"
            } else if tag == "ThirdPoint" {
                description = "ВТБ-Банк"
            }
        }
        
        return description
    }
    
    func makeDescriptionLabel(_ description: String) {
        if descriptionLabel == nil {
            descriptionLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
            descriptionLabel?.center = view.center
            descriptionLabel?.backgroundColor = UIColor.white
            descriptionLabel?.textColor = UIColor.black
            descriptionLabel?.textAlignment = .center
            descriptionLabel?.layer.cornerRadius = 5
            descriptionLabel?.layer.masksToBounds = true
            view.addSubview(descriptionLabel!)
        }
        descriptionLabel?.text = description
        
        UIView.animate(withDuration: 0.5, animations: {
            self.descriptionLabel?.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 2.0, options: [], animations: {
                self.descriptionLabel?.alpha = 0.0
            }) { _ in
                self.descriptionLabel?.removeFromSuperview()
                self.descriptionLabel = nil
            }
        }
    }
}
