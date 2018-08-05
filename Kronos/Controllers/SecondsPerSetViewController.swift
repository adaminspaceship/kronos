//
//  SecondsPerSetViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 24/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit
import CoreData

class SecondsPerSetViewController: UIViewController {
	
	var exercises = [String]()
	var currentExerciseIndex = 0
	var workoutName = String()
	var restSeconds = Int()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		//workout = CoreDataHelper.newWorkout()
        // Do any additional setup after loading the view.
		exerciseNameField.text = exercises[currentExerciseIndex]
		currentExerciseIndex += 1
		
		self.hideKeyboardWhenTappedAround()
		secondsPerSetField.becomeFirstResponder()
		
		let border = CALayer()
		let width = CGFloat(2.0)
		border.borderColor = UIColor.darkGray.cgColor
		border.frame = CGRect(x: 0, y: secondsPerSetField.frame.size.height - width, width: secondsPerSetField.frame.size.width, height: secondsPerSetField.frame.size.height)
		
		border.borderWidth = width
		secondsPerSetField.layer.addSublayer(border)
		secondsPerSetField.layer.masksToBounds = true
		
    }
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
			return false
		}
		return true
	}

	
	@IBOutlet weak var secondsPerSetField: UITextField!
	
	@IBOutlet weak var exerciseNameField: UITextField!
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	//var workout = Workouts()
	
	let defaults = UserDefaults.standard
	var totalExercises = [String:Int]()
	
	
	@IBAction func doneButtonTapped(_ sender: Any) {
		print(currentExerciseIndex)
		if exercises.count <= currentExerciseIndex {
			// done
			let secondsField = Int(secondsPerSetField.text ?? "60")
			totalExercises[exerciseNameField.text ?? "Untitled Exercise"] = secondsField
			//exercisesArray.append(Exercise)
			print("Workout Name: \(workoutName), Rest Seconds: \(restSeconds)")
			let workout = CoreDataHelper.newWorkout()
			workout.workoutName = workoutName
			defaults.set(totalExercises, forKey: workoutName)
			workout.restSeconds = Int16(restSeconds)
			CoreDataHelper.saveWorkout()
		} else {
			// still not finished
			let secondsField = Int(secondsPerSetField.text!)
			totalExercises[exerciseNameField.text ?? "Untitled Exercise"] = secondsField
			exerciseNameField.text = exercises[currentExerciseIndex]
			secondsPerSetField.text = ""
			secondsPerSetField.becomeFirstResponder()
		}
		currentExerciseIndex += 1
	}


}
