//
//  AddStopVC.swift
//  Road Trip
//
//  Created by Jerome Ortega on 1/19/17.
//  Copyright © 2017 Jerome Ortega. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class AddStopVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
	@IBOutlet weak var stopName: UITextField!
	@IBOutlet weak var stopDesc: UITextField!
	@IBOutlet weak var startEndTrip: UIButton!
    @IBOutlet var mapView: MKMapView!
    
    //INITIALIZING MAP MANAGER
    let locationManager = CLLocationManager()
    
	
	@IBAction func ManuallyAddStopPressed(_ sender: UIButton) {
	}
	
	@IBAction func StartEndTripPressed(_ sender: UIButton) {
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //SETUP LOCATION MANAGER
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.mapView.setRegion(region, animated: true)
        self.locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error in location updating and setting map center: ", error.localizedDescription)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
