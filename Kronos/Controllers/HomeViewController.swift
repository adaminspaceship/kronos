//
//  HomeViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 25/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var workouts = [Workout]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		tableView.rowHeight = 60
		
    }
	override func viewDidAppear(_ animated: Bool) {
		workouts = CoreDataHelper.retrieveWorkouts()
		tableView.reloadData()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBOutlet weak var tableView: UITableView!
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return workouts.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
		cell.exerciseLabel.text = workouts[indexPath.row].exerciseName
		let workout = workouts[indexPath.row]
		cell.secondLabel.text = "\(workout.secondsPerSet) seconds"
		cell.numberOfSetsLabel.text = "\(workout.numberOfSets) sets"
		return cell
	}
	var selectedWorkout = Workout()
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let workout = workouts[indexPath.row]
		selectedWorkout = workout
		print("Workout selected: \(workout.exerciseName), number of sets: \(workout.numberOfSets), seconds per set: \(workout.secondsPerSet)")
		self.performSegue(withIdentifier: Constants.segue.toOther, sender: self)
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let workoutToDelete = workouts[indexPath.row]
			CoreDataHelper.delete(workout: workoutToDelete)
			
			workouts = CoreDataHelper.retrieveWorkouts()
			tableView.reloadData()
		}
	}

	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let OtherViewController = segue.destination as? OtherViewController {
			OtherViewController.selectedWorkout = selectedWorkout
		}
	}



}
