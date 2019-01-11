//
//  NewWorkoutViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 03/08/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit

class NewWorkoutViewController: UIViewController, UITextFieldDelegate {

	var imagePicked = "dumbbell"
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
		workoutNameField.delegate = self
		iconButton.imageView?.layer.cornerRadius = buttonView.frame.width/2
		buttonView.layer.cornerRadius = buttonView.frame.width/2
		buttonView.layer.borderWidth = 1
		buttonView.layer.borderColor = UIColor(red:222/255, green:225/255, blue:227/255, alpha: 1).cgColor
    }
	@IBOutlet weak var buttonView: UIView!
	@IBOutlet weak var workoutNameField: UITextField!
	@IBOutlet weak var iconButton: UIButton!
	
	@IBOutlet weak var secondsField: UITextField!
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func nextButtonTapped(_ sender: Any) {
		print("Tapped Next, seguing to add exercises")
		let secondsTime = Int16(self.secondsField.text ?? "60")
		let workout = CoreDataHelper.newWorkout()
		workout.workoutName = workoutNameField.text
		workout.timeSeconds = secondsTime ?? 60
		//workout.workoutIcon = imagePicked
		CoreDataHelper.saveWorkout()
		self.performSegue(withIdentifier: Constants.segue.toHome, sender: self)
	}
	
	@IBAction func iconButtonTapped(_ sender: Any) {
		print("tapped")
	}

	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		let nextTag = textField.tag + 1
		
		if let nextResponder = textField.superview?.viewWithTag(nextTag) {
			nextResponder.becomeFirstResponder()
		} else {
			textField.resignFirstResponder()
		}
		
		return true
	}



}


/*

*/

