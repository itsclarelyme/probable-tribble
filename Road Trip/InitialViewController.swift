//
//  ViewController.swift
//  Road Trip
//
//  Created by Jerome Ortega on 1/19/17.
//  Copyright © 2017 Jerome Ortega. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, AllTripVCDelegate {

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
<<<<<<< HEAD
        let button: UIButton = (sender as? UIButton)!
        if button.tag == 2 {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! AllTripTVC
            controller.delegate = self
        }
=======
		let button: UIButton = (sender as? UIButton)!
		if button.tag == 2 {
			let navigationController = segue.destination as! UINavigationController
			let controller = navigationController.topViewController as! AllTripTVC
			controller.delegate = self
>>>>>>> 51432002960c1d98de2d4d62c5fc1c38be789418
		}
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

