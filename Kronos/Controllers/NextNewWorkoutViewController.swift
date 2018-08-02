//
//  NextNewWorkoutViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 24/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit
import CoreData

class NextNewWorkoutViewController: UIViewController {
	
	var setCountLabel = Int()
	var workoutName = String()
	var secondsRest = Int()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		workoutNameField.text = workoutName
		self.hideKeyboardWhenTappedAround()
		secondsPerSetField.becomeFirstResponder()
		
    }
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
			return false
		}
		return true
	}

	
	@IBOutlet weak var secondsPerSetField: UITextField!
	
	@IBOutlet weak var workoutNameField: UITextField!
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
    
	@IBAction func doneButtonTapped(_ sender: Any) {

		let workout = CoreDataHelper.newExercise()
		workout.exerciseName = workoutName
		workout.numberOfSets = Int32(setCountLabel)
		workout.secondsPerSet = Int32(secondsPerSetField.text ?? "60") ?? 60
		workout.restTime = Int32(secondsRest ?? 30) ?? 30
		CoreDataHelper.saveExercise()
		
	}



}
