//
//  ShopMap.swift
//  Assignment
//
//  Created by k ph on 14/1/2022.
//

import UIKit
import MapKit
import CoreLocation

class ShopMap: UIViewController, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager?
    var annotations = [MKPointAnnotation]();
    @IBOutlet weak var longText: UITextField!
    @IBOutlet weak var latitText: UITextField!
    @IBOutlet weak var accuracyText: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager();
            self.locationManager?.delegate = self;
        if CLLocationManager.authorizationStatus() != .authorizedAlways {
            self.locationManager?.requestAlwaysAuthorization();
        }
        else {
            self.setupAndStartLocationManager();
        }
        }
        let nycAnnotation = MKPointAnnotation();
         nycAnnotation.coordinate = CLLocationCoordinate2D(latitude: 22.209501208046525, longitude: 114.02934296873738);
         nycAnnotation.title = "Sugar Man";
         self.annotations.append(nycAnnotation);
         
         self.mapView?.addAnnotations(self.annotations);
    }
        
        //for in-app authorization event
        func locationManager(_ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
        self.setupAndStartLocationManager();
        }
        }
        
        func setupAndStartLocationManager(){
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager?.distanceFilter = kCLDistanceFilterNone;
        self.locationManager?.startUpdatingLocation();
        }
    
        func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                self.latitText?.text = "\(location.coordinate.latitude)";
                self.longText?.text = "\(location.coordinate.longitude)";
                self.accuracyText?.text = "\(location.horizontalAccuracy)";
     
                let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01);
                let coord = location.coordinate;
                let region = MKCoordinateRegion(center: coord, span: span)
                self.mapView?.setRegion(region, animated: false);
            }
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
