import UIKit
import CoreLocation
import YandexMapsMobile

extension MapDisplayerVC {
    func zoomButtonTapped(_ zoom: Float) {
        let currentZoom = mapView.mapWindow.map.cameraPosition.zoom
        let newZoom = currentZoom + zoom
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(
                target: mapView.mapWindow.map.cameraPosition.target,
                zoom: newZoom,
                azimuth: mapView.mapWindow.map.cameraPosition.azimuth,
                tilt: mapView.mapWindow.map.cameraPosition.tilt
            ),
            animationType: YMKAnimation(type: .smooth, duration: 0.3),
            cameraCallback: nil
        )
    }
}
