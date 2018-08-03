//
//  NewWorkoutViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 03/08/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit

class NewWorkoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		let workouts = CoreDataHelper.retrieveWorkouts()
		for a in workouts {
			print(a.exercises?[0].exerciseName)
			print(a.restSeconds)
			print(a.workoutName)
		}
        // Do any additional setup after loading the view.
    }
	@IBOutlet weak var workoutNameField: UITextField!
	@IBOutlet weak var restSecondsField: UITextField!
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func nextButtonTapped(_ sender: Any) {
		
	}
	
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let AddExercisesViewController = segue.destination as? AddExercisesViewController {
			AddExercisesViewController.restSeconds = Int(restSecondsField.text ?? "60") ?? 60
			AddExercisesViewController.workoutName = workoutNameField.text ?? "Untitled Workout"
		}
    }


}
