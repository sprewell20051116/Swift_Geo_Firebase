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

    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLocationManager();

        let ref = Firebase(url: "https://glaring-inferno-1919.firebaseio.com/test");
        ref.observeEventType(.Value, withBlock: { snapshot in
            print(snapshot.value);
            
            }, withCancelBlock: { error in
                print(error.description);
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initLocationManager() {
        locationManager.delegate = self;
        locationManager.requestAlwaysAuthorization();
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
        print("lcoation");
    }
}

