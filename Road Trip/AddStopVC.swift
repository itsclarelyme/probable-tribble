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
import CoreData

class AddStopVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
	
	weak var delegate: EndTripDelegate?

	@IBOutlet weak var tripName: UILabel!
	@IBOutlet weak var stopName: UITextField!
	@IBOutlet weak var stopDesc: UITextField!
	@IBOutlet weak var startEndTrip: UIButton!
	@IBOutlet var mapView: MKMapView!
	var mapImage: UIImage!
    
	//INITIALIZING MAP/OBJECT MANAGER
	let locationManager = CLLocationManager()
	let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	
	//INITIALIZE VARIABLES
	var stops = [Stop]()
	var stop_ind = 0
	var cur_long: Double = 0.0
	var cur_lad: Double = 0.0
	var trip_id: Int64 = 0
	var trip_Name: String?
	
	@IBAction func ManuallyAddStopPressed(_ sender: UIButton) {
		//let newstop_location
		stop_ind += 1
		
		//CREATE NEW STOP INSTANCE
		//let newstop = NSEntityDescription.insertNewObject(forEntityName: "Stop", into: managedObjectContext) as! Stop
		
		var newstopname = stopName.text
		if newstopname == ""{
			newstopname = "Stop #" + String(stop_ind)
		}
		
		var newstopdes = stopDesc.text
		if newstopdes == "" {
			newstopdes = "we stopped here!"
		}
		let newstoplong = cur_long
		let newstoplad = cur_lad
		AddStop(with: newstopname!, Description: newstopdes!, laditude: newstoplad, longitude: newstoplong)
		addMarker(with: newstopname!, with: newstoplad, with: newstoplong)
		//newstop.trip = trip
		//print("this is the stop name: ", newstop)
		//saveStop()
		//RESET ALL TEXT FIELD TO NULL
		stopName.text = ""
		stopDesc.text = ""
	}
	
	@IBAction func StartEndTripPressed(_ sender: UIButton) {
		//ADD A STOP
		AddStop(with: "End Point", Description: "Amazing End to an Amazing Trip!", laditude: cur_lad, longitude: cur_long)
		//ADD A MARKER
		addMarker(with: "End Point", with: cur_lad, with: cur_long)

		//SCREENSHOT MAP
		let options = MKMapSnapshotOptions()
		options.region = mapView.region
		options.size = mapView.frame.size
		options.scale = UIScreen.main.scale
		
		let snapshotter = MKMapSnapshotter(options: options)
		snapshotter.start { snapshot, error in guard let snapshot = snapshot else {
			print("Snapshot Error: \(error)")
			return
			}
			self.mapImage = snapshot.image
			self.locationManager.stopUpdatingLocation()
		}
		
//		self.myEvent.picture = UIImageJPEGRepresentation(chosenImage, 1);
//		To retrieve it from Core Data, we’ll do the opposite:
//		
//		self.imageView.image = [UIImage imageWithData:self.myEvent.picture];
		
		//REDIRECT VC
		delegate?.endButtonPressed(by: self)
	}

    override func viewDidLoad() {
        super.viewDidLoad()
			print(trip_id)
			print(trip_Name)
				self.mapView.delegate = self
        // Do any additional setup after loading the view.
        
        //SETUP LOCATION MANAGER
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
			
			//Looks for single or multiple taps.
				let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddStopVC.dismissKeyboard))
			
				view.addGestureRecognizer(tap)
		}
	
		func dismissKeyboard() {
			view.endEditing(true)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
			self.locationManager.startUpdatingLocation()
			let location = locations.last
			cur_lad = location!.coordinate.latitude
			cur_long = location!.coordinate.longitude
			//USE THE LABEL TO SHOW CORD
			tripName.text = "lad: \(cur_lad), long: \(cur_long)"
			if stop_ind == 0 {
				let start = NSEntityDescription.insertNewObject(forEntityName: "Stop", into: managedObjectContext) as! Stop
				start.stop_name = "Start"
				addMarker(with: "Start", with: cur_lad, with: cur_long)
				stop_ind += 1
				
			}
			let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
			let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
			self.mapView.setRegion(region, animated: true)
    }
	
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error in location updating and setting map center: ", error.localizedDescription)
    }
	
	
	func AddStop(with name: String, Description des: String, laditude lad: Double, longitude long: Double){
		let newstop = NSEntityDescription.insertNewObject(forEntityName: "Stop", into: managedObjectContext) as! Stop
		newstop.stop_name = name
		newstop.stop_des = des
		newstop.lad = lad
		newstop.long = long
		print("we are adding stops: ", newstop)
		saveStop()
		
	}
	
	func addMarker(with name: String, with lad: Double, with long: Double){
		//ADD MARKER FUNCTION
		let this_loc = CLLocationCoordinate2DMake(lad, long)
		let this_marker = MKPointAnnotation()
		this_marker.coordinate = this_loc
		this_marker.title = name
		mapView.addAnnotation(this_marker)
	}
	
	//FOR UPDATING DATA AFTER ADDING
	func saveStop(){
		if managedObjectContext.hasChanges {
			do {
				try managedObjectContext.save()
				print("Success")
			} catch {
				print("\(error)")
			}
		}
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
