//
//  AllTripTVC.swift
//  Road Trip
//
//  Created by Jerome Ortega on 1/19/17.
//  Copyright © 2017 Jerome Ortega. All rights reserved.
//

import UIKit

class AllTripTVC: UITableViewController, tripSummaryVCDelegate, EndTripDelegate {
	
	weak var delegate: AllTripVCDelegate?
	
	let things = ["Hello"]
	
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
			let navigationController = segue.destination as! AddStopVC
			let controller = navigationController
			controller.delegate = self
		}
	}
	
	func endButtonPressed(by controller: AddStopVC) {
		dismiss(animated: true, completion: nil)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

				tableView.dataSource = self
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation,q return the number of sections
        return things.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return things.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath)
		// set text label to the model that is corresponding to the row in array
		cell.textLabel?.text = things[indexPath.row]
		// return cell so that Table View knows what to render in each row
		return cell
	}
	
		override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
			
		}



}
