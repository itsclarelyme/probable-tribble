//
//  TripSummaryVC.swift
//  Road Trip
//
//  Created by Jerome Ortega on 1/19/17.
//  Copyright © 2017 Jerome Ortega. All rights reserved.
//

import UIKit

class TripSummaryVC: UITableViewController, StopDetailsViewControllerDelegate {
	
	let things = ["Start", "National Forest", "Tasty Restaurant", "Interesting Landmark"]
	var tripID: String?
	
	weak var delegate: tripSummaryVCDelegate?
	
	@IBAction func backButtonWasPressed(_ sender: UIBarButtonItem) {
		delegate?.backButtonPressed(by: self)
		dismiss(animated: true, completion: nil)
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		// #warning Incomplete implementation,q return the number of sections
		return things.count
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return things.count // your number of cell here
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "StopCell", for: indexPath)
		// set text label to the model that is corresponding to the row in array
		cell.textLabel?.text = things[indexPath.row]
		
		
		// return cell so that Table View knows what to render in each row
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let navigationController = segue.destination as! UINavigationController
		let controller = navigationController.topViewController as! StopDetailsViewController
		controller.deleGate = self
	}
	
	func backButtonPressed(by controller: StopDetailsViewController) {
		dismiss(animated: true, completion: nil)
	}
	
	func saveButtonPressed(by controller: StopDetailsViewController) {
		dismiss(animated: true, completion: nil)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
				tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
