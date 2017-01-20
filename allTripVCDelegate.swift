//
//  allTripVCDelegate.swift
//  Road Trip
//
//  Created by Jerome Ortega on 1/19/17.
//  Copyright © 2017 Jerome Ortega. All rights reserved.
//

import UIKit

protocol AllTripVCDelegate: class {
	func cancelButtonPressedDown(by controller: UITableViewController)
}

protocol EndTripDelegate: class {
	func endButtonPressed(by controller: AddStopVC)
}
