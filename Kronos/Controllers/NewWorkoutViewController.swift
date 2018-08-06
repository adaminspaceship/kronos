//
//  NewWorkoutViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 03/08/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit

class NewWorkoutViewController: UIViewController, UITextFieldDelegate {

	let defaults = UserDefaults.standard
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
		workoutNameField.delegate = self
		addDoneButtonOnKeyboard()
    }
	@IBOutlet weak var workoutNameField: UITextField!
	@IBOutlet weak var restSecondsField: UITextField!
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func nextButtonTapped(_ sender: Any) {
		
	}
	
	
	func addDoneButtonOnKeyboard() {
		let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
		doneToolbar.barStyle       = UIBarStyle.default
		let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
		let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(doneButtonAction))
		
		var items = [UIBarButtonItem]()
		items.append(flexSpace)
		items.append(done)
		
		doneToolbar.items = items
		doneToolbar.sizeToFit()
		
		self.restSecondsField.inputAccessoryView = doneToolbar
	}
	
	@objc func doneButtonAction() {
		self.restSecondsField.resignFirstResponder()
		print("Tapped Done, seguing to add exercises")
		self.performSegue(withIdentifier: Constants.segue.toAddExercises, sender: self)
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
	
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let AddExercisesViewController = segue.destination as? AddExercisesViewController {
			AddExercisesViewController.restSeconds = Int(restSecondsField.text ?? "60") ?? 60
			AddExercisesViewController.workoutName = workoutNameField.text ?? "Untitled Workout"
		}
    }


}
