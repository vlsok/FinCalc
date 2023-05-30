import UIKit
import CoreLocation
import YandexMapsMobile

extension MapDisplayerVC {
    @objc(locationManager:didChangeAuthorizationStatus:)
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }

    @objc
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.first else { return }

        let userPoint = YMKPoint(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        mapView.mapWindow.map.mapObjects.addPlacemark(with: userPoint)

        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: userPoint, zoom: 17, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: .smooth, duration: 5),
            cameraCallback: nil
        )

        manager.stopUpdatingLocation()
    }
}
