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
	@IBOutlet weak var noTimerLabel: UILabel!
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		workouts = CoreDataHelper.retrieveWorkouts()
		if workouts.count == 0 {
			self.noTimerLabel.isHidden = false
		}
		return workouts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell") as! WorkoutTableViewCell
		let workout = workouts[indexPath.row]
		cell.workoutNameLabel.text = workout.workoutName
		print(workout.timeSeconds)
		cell.workoutIconImage.image = UIImage(named: workout.workoutIcon ?? "dumbbell")
		return cell
	}

	var selectedWorkoutName = String()
	var selectedWorkoutTime = Int16()
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let selectedWorkout = workouts[indexPath.row]
		selectedWorkoutName = selectedWorkout.workoutName!
		selectedWorkoutTime = selectedWorkout.timeSeconds
		self.performSegue(withIdentifier: Constants.segue.toTimer, sender: self)
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			CoreDataHelper.delete(workouts: workouts[indexPath.row])
			tableView.reloadData()
		}
	}
	

	
	override func viewDidLoad() {
        super.viewDidLoad()
		tableView.rowHeight = 80
		
		for a in workouts {
			print(a.timeSeconds)
			print(a.workoutName!)
			print(a.workoutIcon ?? "")
		}
		
		
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let TimerViewController = segue.destination as? TimerViewController {
			TimerViewController.secondsTime = selectedWorkoutTime
			TimerViewController.selectedWorkoutName = selectedWorkoutName
		}
	}

}
