//
//  WorkoutsViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 02/08/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit
import CoreData

class WorkoutsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	@IBOutlet weak var tableView: UITableView!
	
	var workouts = [Workouts]()
	var selectedWorkout = String()
	var selectedWorkoutRestTime = Int()
	let defaults = UserDefaults.standard
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return workouts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell") as! WorkoutTableViewCell
		let workout = workouts[indexPath.row]
		cell.workoutNameLabel.text = workout.workoutName
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		selectedWorkout = workouts[indexPath.row].workoutName!
		selectedWorkoutRestTime = Int(workouts[indexPath.row].restSeconds)
		self.performSegue(withIdentifier: Constants.segue.toExercises, sender: self)
	}
	

	
	override func viewDidLoad() {
        super.viewDidLoad()
		//tableView.rowHeight = 80
		workouts = CoreDataHelper.retrieveWorkouts()
		for a in workouts {
			print(defaults.dictionary(forKey: a.workoutName!))
			print(a.restSeconds)
			print(a.workoutName)
		}
		
		
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     
	
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		if let HomeViewController = segue.destination as? HomeViewController {
			HomeViewController.selectedWorkout = selectedWorkout
			HomeViewController.selectedWorkoutRestTime = selectedWorkoutRestTime
		}

    }


}
