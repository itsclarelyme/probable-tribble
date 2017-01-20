//
//  AllTripTVC.swift
//  Road Trip
//
//  Created by Jerome Ortega on 1/19/17.
//  Copyright © 2017 Jerome Ortega. All rights reserved.
//

import UIKit
import CoreData

class AllTripTVC: UITableViewController, tripSummaryVCDelegate, EndTripDelegate {
	
	weak var delegate: AllTripVCDelegate?
	
	//INITIALZE VARIOABLES
	var trips = [Trip]()
	let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	@IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
		delegate?.cancelButtonPressedDown(by: self)
	}
	
	func backButtonPressed(by controller: UIViewController) {
		dismiss(animated: true, completion: nil)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if ((sender as? UITableViewCell) != nil){
			let navigationController = segue.destination as! UINavigationController
			let controller = navigationController.topViewController as! TripSummaryVC
			controller.delegate = self
		}
		else {
			let tripInfo = newTrip()
			let navigationController = segue.destination as! AddStopVC
			let controller = navigationController
			controller.delegate = self
			controller.trip_Name = tripInfo.name
			controller.trip_id = tripInfo.trip_id
			
		}
	}
	
	func endButtonPressed(by controller: AddStopVC) {
		dismiss(animated: true, completion: nil)
		//RELOAD
		fetchData()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.dataSource = self
		fetchData()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Table view data source
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		return trips.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath)
		// set text label to the model that is corresponding to the row in array
		cell.textLabel?.text = trips[indexPath.row].name
		// return cell so that Table View knows what to render in each row
		return cell
	}
	
	func newTrip() -> Trip{
		let newtrip = NSEntityDescription.insertNewObject(forEntityName: "Trip", into: managedObjectContext) as! Trip
		if trips.count == 0{
			newtrip.trip_id = 0
			newtrip.name = "Awesome New Trip #1!"

		}
		else{
			newtrip.trip_id = trips[trips.count - 1].trip_id + 1
			newtrip.name = "Awesome New Trip #\(newtrip.trip_id)!"
		}
		
		
		saveTrip()
		return newtrip
	}
	
	    func AddTrip(){
	        //trip1
	        let trip1 = NSEntityDescription.insertNewObject(forEntityName: "Trip", into: managedObjectContext) as! Trip
	        trip1.name = "Trip #1"
	        trip1.trip_id = 0
	        saveTrip()
	        //trip2
	        let trip2 = NSEntityDescription.insertNewObject(forEntityName: "Trip", into: managedObjectContext) as! Trip
	        trip2.name = "Trip #2"
	        trip2.trip_id = 1
	        saveTrip()
	        fetchData()
	
	    }
	
	//FOR UPDATING DATA AFTER ADDING
	func saveTrip(){
		if managedObjectContext.hasChanges {
			do {
				try managedObjectContext.save()
				print("Success")
			} catch {
				print("\(error)")
			}
		}
	}
	
	//FETCH DATA
	func fetchData(){
		let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Trip")
		do {
			// get the results by executing the fetch request we made earlier
			let results = try managedObjectContext.fetch(itemRequest)
			// downcast the results as an array of Mission objects
			trips = results as! [Trip]
			// print the details of each item
			for trip in trips {
				print("\(trip.name)")
			}
		} catch {
			// print the error if it is caught (Swift automatically saves the error in "error")
			print("\(error)")
		}
		tableView.reloadData()
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
	}
}
