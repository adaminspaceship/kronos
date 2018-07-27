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
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		workoutNameField.text = workoutName
		self.hideKeyboardWhenTappedAround()
		secondsPerSetField.becomeFirstResponder()
		
    }
	@IBOutlet weak var secondsPerSetField: UITextField!
	
	@IBOutlet weak var workoutNameField: UITextField!
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	let workout = CoreDataHelper.newWorkout()
    
	@IBAction func doneButtonTapped(_ sender: Any) {

		
		workout.exerciseName = workoutName
		workout.numberOfSets = Int32(setCountLabel)
		workout.secondsPerSet = Int32(secondsPerSetField.text!)!
		CoreDataHelper.saveWorkout()
		
	}



}
