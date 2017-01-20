//
//  TripSummaryVC.swift
//  Road Trip
//
//  Created by Jerome Ortega on 1/19/17.
//  Copyright © 2017 Jerome Ortega. All rights reserved.
//

import UIKit

class TripSummaryVC: UIViewController {
	
	weak var delegate: tripSummaryVCDelegate?
	
	@IBAction func backButtonWasPressed(_ sender: UIBarButtonItem) {
		delegate?.backButtonPressed(by: self)
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
