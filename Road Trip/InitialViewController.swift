//
//  ViewController.swift
//  Road Trip
//
//  Created by Jerome Ortega on 1/19/17.
//  Copyright © 2017 Jerome Ortega. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, AllTripVCDelegate, EndTripDelegate {

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let button: UIButton = (sender as? UIButton)!
		if button.tag == 2 {
			let navigationController = segue.destination as! UINavigationController
			let controller = navigationController.topViewController as! AllTripTVC
			controller.delegate = self
		} else {
			let navigationController = segue.destination as! UIViewController
			let controller = navigationController as! AddStopVC
			controller.delegate = self
		}
	}
	
	func endButtonPressed(by controller: UIViewController) {
		dismiss(animated: true, completion: nil)
	}
	
	func cancelButtonPressedDown(by controller: UITableViewController) {
		dismiss(animated: true, completion: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

