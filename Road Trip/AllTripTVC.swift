//
//  AllTripTVC.swift
//  Road Trip
//
//  Created by Jerome Ortega on 1/19/17.
//  Copyright © 2017 Jerome Ortega. All rights reserved.
//

import UIKit
//import CoreData

class AllTripTVC: UITableViewController, tripSummaryVCDelegate, EndTripDelegate {
	
	var user: String?
	weak var delegate: AllTripVCDelegate?
	
	//INITIALZE VARIOABLES
	let sectionName = ["Current Trip", "My Trip"]
	var trips = [String?]()
	var cur_trip = [String?]()
	var trip_info = [NSDictionary?]()
	
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
		else if segue.identifier == "tracking"{
			//let tripInfo = newTrip()
			let controller = segue.destination as! AddStopVC
			controller.delegate = self
			//controller.tripID = trip_info["_id"]
			//controller.trip_Name = tripInfo.name
			//controller.trip_id = tripInfo.trip_id
			
		}
	}
	
	func endButtonPressed(by controller: AddStopVC) {
		dismiss(animated: true, completion: nil)
		//RELOAD
		//fetchData()
		trips = []
		getTrip()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.dataSource = self
		
		print("all trip load view")
		
		// specify the url that we will be sending the GET request to
		let url = URL(string: "http://54.147.189.68/trips")
		// create a URLSession to handle the request tasks
		let session = URLSession.shared
		// create a "data task" to make the request and run completion handler
		let task = session.dataTask(with: url!, completionHandler: {
			// see: Swift closure expression syntax
			data, response, error in
			do {
				print("getting response back")
				if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
					print(jsonResult)
					for trip in jsonResult{
						print(trip)
						self.trip_info.append(trip as? NSDictionary)
						self.trips.append((trip as! NSDictionary).value(forKey: "name") as? String)
					}
					DispatchQueue.main.async {
						self.tableView.reloadData()
					}
				}
			} catch {
				print(error)
			}
		})
		// execute the task and then wait for the response
		// to run the completion handler. This is async!
		task.resume()
		
	}
	
	func getTrip(){
		let url = URL(string: "http://54.147.189.68/trips")
		let session = URLSession.shared
		let task = session.dataTask(with: url!, completionHandler: {
			data, response, error in
			do {
				print("getting response back")
				if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
					print(jsonResult)
					for trip in jsonResult{
						print(trip)
						self.trip_info.append(trip as? NSDictionary)
						self.trips.append((trip as! NSDictionary).value(forKey: "name") as? String)
						DispatchQueue.main.async {
							self.tableView.reloadData()
						}
					}
				}
			} catch {
				print(error)
			}
		})
		//        print("array of all trips: ", trips)
		task.resume()
		OperationQueue.main.addOperation {
			self.tableView.reloadData()
			
		}
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Table view data source
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return self.sectionName[section]
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of rows
		
		if section == 0{
			return cur_trip.count
		}
		else{
			return trips.count
		}
	}
	
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell()
		if indexPath.section == 0 {
			cell.textLabel?.text = cur_trip[indexPath.row]
		}
		else {
			cell.textLabel?.text = trips[indexPath.row]
		}
		return cell
	}
	
	///////CHECK SEGUE
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "showTrip", sender: indexPath)
	}
}
