//
//  StopDetailsViewController.swift
//  Road Trip
//
//  Created by Jerome Ortega on 1/19/17.
//  Copyright © 2017 Jerome Ortega. All rights reserved.
//

import UIKit

class StopDetailsViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	weak var deleGate: StopDetailsViewControllerDelegate?
	
	@IBOutlet weak var stopDescript: UITextView!
	@IBOutlet weak var imagePicked: UIImageView!
	
	@IBAction func backButtonPressed(_ sender: UIBarButtonItem) {
		deleGate?.backButtonPressed(by: self)
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
		if (imagePicked.image != nil){
			let imageData = UIImageJPEGRepresentation(imagePicked.image!, 0.6)
			let compressedJPGImage = UIImage(data: imageData!)
			UIImageWriteToSavedPhotosAlbum(compressedJPGImage!, nil, nil, nil)
			let alert = UIAlertView(title: "", message: "Your image has been saved to Photo Library!", delegate: nil, cancelButtonTitle: "Ok")
			alert.show()
		}
		deleGate?.saveButtonPressed(by: self)
	}
	
	@IBAction func takePhotoButtonPressed(_ sender: UIButton) {
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
			var imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
			imagePicker.allowsEditing = false
			self.present(imagePicker, animated: true, completion: nil)
		}
	}
	
	@IBAction func choosePhotoButtonPressed(_ sender: UIButton) {
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
			var imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
			imagePicker.allowsEditing = true
			self.present(imagePicker, animated: true, completion: nil)
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		var chosenImage = UIImage()
		chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
		imagePicked.image = chosenImage
		imagePicked.contentMode = .scaleAspectFit
		print("Updated Image")
		self.dismiss(animated: true, completion: nil);
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
			stopDescript.layer.borderWidth = 2
			stopDescript.layer.cornerRadius = 5
			stopDescript.layer.borderColor = UIColor.black.cgColor
		// Do any additional setup after loading the view.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	
	
}
