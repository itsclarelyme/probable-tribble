//
//  AddStopVC.swift
//  Road Trip
//
//  Created by Jerome Ortega on 1/19/17.
//  Copyright © 2017 Jerome Ortega. All rights reserved.
//

import UIKit

class AddStopVC: UIViewController {
	@IBOutlet weak var stopName: UITextField!
	@IBOutlet weak var stopDesc: UITextField!
	@IBOutlet weak var startEndTrip: UIButton!
	
	@IBAction func ManuallyAddStopPressed(_ sender: UIButton) {
	}
	
	@IBAction func StartEndTripPressed(_ sender: UIButton) {
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
