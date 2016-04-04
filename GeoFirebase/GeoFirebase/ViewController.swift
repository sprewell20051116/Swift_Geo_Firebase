//
//  ViewController.swift
//  GeoFirebase
//
//  Created by GIGIGUN on 4/2/16.
//  Copyright © 2016 GIGIGUN. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let locationManager = CLLocationManager() // Add this statement
    var locationUpdateTimer = NSTimer();
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocationManager();
// Firebase blocks
//
//        let ref = Firebase(url: "https://glaring-inferno-1919.firebaseio.com/test");
//        ref.observeEventType(.Value, withBlock: { snapshot in
//            print(snapshot.value);
//            
//            }, withCancelBlock: { error in
//                print(error.description);
//        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initLocationManager() {
        locationManager.delegate = self;
        locationManager.requestAlwaysAuthorization();
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationUpdateTimer = NSTimer.scheduledTimerWithTimeInterval(3600, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)

        }
    }
    
    func update() {
        locationManager.startUpdatingLocation();
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
        print(#function);
    
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {

        let center = CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

        mapView.setRegion(region, animated: true)
        print(#function);

    }
    
}

