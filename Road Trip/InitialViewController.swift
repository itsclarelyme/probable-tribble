//
//  ViewController.swift
//  Road Trip
//
//  Created by Jerome Ortega on 1/19/17.
//  Copyright © 2017 Jerome Ortega. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, AllTripVCDelegate {
	
	
	var user:String = ""
	
	@IBOutlet weak var userL: UILabel!
	@IBOutlet weak var userTF: UITextField!
	@IBAction func allTripsButtonPressed(_ sender: UIButton) {
		if userTF.text == ""{
			userL.text = "Please enter your user name!"
		}else{
			user = userTF.text!
			addTaskWithObjective(objective: userTF.text!, completionHandler: {
				data, response, error in
				print(data)
			})
			performSegue(withIdentifier: "mainSegue", sender: sender)
		}
	}
	

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let tabController = segue.destination as! UITabBarController
		let navigationController = tabController.viewControllers!.first as! UINavigationController
		let receiverVC = navigationController.viewControllers.first as! AllTripTVC
		receiverVC.delegate = self
		receiverVC.user = user
	}
	
	func cancelButtonPressedDown(by controller: UITableViewController) {
		dismiss(animated: true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddStopVC.dismissKeyboard))
		view.addGestureRecognizer(tap)
	}

	func dismissKeyboard() {
		view.endEditing(true)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func addTaskWithObjective(objective: String, completionHandler: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
		// Create the url to request
		if let urlToReq = URL(string: "http://54.147.189.68/users") {
			// Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
			let request = NSMutableURLRequest(url: urlToReq)
			// Set the method to POST
			request.httpMethod = "POST"
			// Create some bodyData and attach it to the HTTPBody
			let bodyData = "name=\(objective)"
			request.httpBody = bodyData.data(using: String.Encoding.utf8)
			// Create the session
			let session = URLSession.shared
			let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
			task.resume()
		}
	}
	
	

}

