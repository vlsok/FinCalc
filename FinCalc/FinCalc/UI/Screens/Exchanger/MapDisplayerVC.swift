import UIKit
import CoreLocation
import YandexMapsMobile

class MapDisplayerVC: UIViewController, CLLocationManagerDelegate, YMKMapObjectTapListener {
    let locationManager = CLLocationManager()
    let styleSheet = StyleSheet()
    
    let buttonSize: CGFloat = 50
    
    var mapView: YMKMapView!
    var descriptionLabel: UILabel?
    
    var mapObjectTags: [YMKPlacemarkMapObject: String] = [:]
    
    var zoomInButton: UIButton!
    var zoomOutButton: UIButton!
    var yaButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = YMKMapView(frame: view.bounds)
        
        let targetLocation = YMKPoint(latitude: 53.902735, longitude: 27.555691)
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: targetLocation, zoom: 6, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: .smooth, duration: 5),
            cameraCallback: nil
        )
        
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        makeZoomInButton()
        makeZoomOutButton()
        makeYaButton()
        
        makePointMapObject(7.5, UIColor.red, 53.905509, 27.561651, "FirstPoint")
        makePointMapObject(7.5, UIColor.green, 53.905599, 27.539508, "SecondPoint")
        makePointMapObject(7.5, UIColor.blue, 53.888807, 27.538556, "ThirdPoint")

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        let buttonsContainer = UIView()
        buttonsContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsContainer)

        buttonsContainer.addSubview(zoomInButton)
        buttonsContainer.addSubview(zoomOutButton)
        buttonsContainer.addSubview(yaButton)

        NSLayoutConstraint.activate([
            buttonsContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            buttonsContainer.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            buttonsContainer.widthAnchor.constraint(equalTo: zoomInButton.widthAnchor, constant: 40)
        ])

        NSLayoutConstraint.activate([
            zoomInButton.topAnchor.constraint(equalTo: buttonsContainer.topAnchor, constant: 70),
            zoomInButton.leadingAnchor.constraint(equalTo: buttonsContainer.leadingAnchor, constant: 20),
            zoomInButton.widthAnchor.constraint(equalToConstant: buttonSize),
            zoomInButton.heightAnchor.constraint(equalToConstant: buttonSize)
        ])

        NSLayoutConstraint.activate([
            zoomOutButton.topAnchor.constraint(equalTo: zoomInButton.bottomAnchor, constant: 20),
            zoomOutButton.leadingAnchor.constraint(equalTo: buttonsContainer.leadingAnchor, constant: 20),
            zoomOutButton.trailingAnchor.constraint(equalTo: buttonsContainer.trailingAnchor, constant: -20),
            zoomOutButton.heightAnchor.constraint(equalToConstant: buttonSize)
        ])

        NSLayoutConstraint.activate([
            yaButton.topAnchor.constraint(equalTo: zoomOutButton.bottomAnchor, constant: 20),
            yaButton.leadingAnchor.constraint(equalTo: buttonsContainer.leadingAnchor, constant: 20),
            yaButton.trailingAnchor.constraint(equalTo: buttonsContainer.trailingAnchor, constant: -20),
            yaButton.bottomAnchor.constraint(equalTo: buttonsContainer.bottomAnchor),
            yaButton.heightAnchor.constraint(equalToConstant: buttonSize)
        ])
    }
    
    func onMapObjectTap(with mapObject: YMKMapObject, point: YMKPoint) -> Bool {
        if mapObject is YMKPlacemarkMapObject {
            makeDescriptionLabel(makeDescription(mapObject))
        }
        
        return true
    }
    
    @objc
    func zoomInButtonTapped() {
        zoomButtonTapped(1)
    }

    @objc
    func zoomOutButtonTapped() {
        zoomButtonTapped(-1)
    }
    
    @objc
    func yaButtonTapped() {
        guard let userLocation = locationManager.location else {
            return
        }
        
        let userPoint = YMKPoint(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: userPoint, zoom: 17, azimuth: 0, tilt: 0),
            animationType: YMKAnimation(type: .smooth, duration: 1),
            cameraCallback: nil
        )
    }

    @objc
    func buttonHighlight(_ sender: UIButton) {
        sender.backgroundColor = UIColor(white: 0.7, alpha: 1.0)
    }

    @objc
    func buttonUnhighlight(_ sender: UIButton) {
        sender.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
    }
}


