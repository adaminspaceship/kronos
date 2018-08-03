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
	
	var currentIndexPath = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
		//workout = CoreDataHelper.newWorkout()
        // Do any additional setup after loading the view.
		exerciseNameField.text = exercises[currentIndexPath]
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
	@IBAction func doneButtonTapped(_ sender: Any) {
		let exercise = Exercise(exerciseName: exercises[currentIndexPath], secondsPerSet: Int(secondsPerSetField.text ?? "60") ?? 60)
		//workout.exercises?.append(exercise)
		if exercises.count == currentIndexPath {
			print("done")
		} else {
			print("still not done")
			currentIndexPath += 1
		}
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let AddExercisesViewController = segue.destination as? AddExercisesViewController {
			AddExercisesViewController.currentIndexPath = currentIndexPath
			AddExercisesViewController.exercises = exercises
		}
	}

}
