//
//  MapVC.swift
//  FoursquareClone
//
//  Created by emn on 8.05.2022.
//

import UIKit
import MapKit
import Parse

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(backButtonClicked))

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtonClicked))
        
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3
        self.mapView.addGestureRecognizer(recognizer)
        
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let location  = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == .began {
            let touches = gestureRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(annotation)
            
            PlaceModel.sharedInstance.placeLatitude = String(coordinates.latitude)
            PlaceModel.sharedInstance.palceLongitude = String(coordinates.longitude)
        }
    }

    @objc func saveButtonClicked() {
        let placeModel = PlaceModel.sharedInstance
        let object = PFObject(className: "Places")
        object["name"] = placeModel.placeName
        object["type"] = placeModel.placeType
        object["atmosphere"] = placeModel.placeAtmosphere
        object["latitude"] = placeModel.placeLatitude
        object ["longitude"] = placeModel.palceLongitude
        
        if let imageData = placeModel.placeImage.jpegData(compressionQuality: 0.5) {
            object["image"] = PFFileObject(name: "image.jpg", data: imageData)
            
        }
        object.saveInBackground { succes, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true)
            } else {
                self.performSegue(withIdentifier: "fromMapVCtoPlaceVC", sender: nil)
            }
        }
    }
    
    @objc func backButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }

}
