//
//  StopDetailsViewControllerDelegate.swift
//  Road Trip
//
//  Created by Jerome Ortega on 1/19/17.
//  Copyright © 2017 Jerome Ortega. All rights reserved.
//

import UIKit

protocol StopDetailsViewControllerDelegate: class {
	func backButtonPressed(by controller: StopDetailsViewController)
	func saveButtonPressed(by controller: StopDetailsViewController)
}
