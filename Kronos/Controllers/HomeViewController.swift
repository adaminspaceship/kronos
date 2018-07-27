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
		let secondsPerSet = workouts[indexPath.row].secondsPerSet
		cell.secondLabel.text = "\(secondsPerSet) seconds"
		return cell
	}
	var selectedWorkout = Workout()
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let workout = workouts[indexPath.row]
		selectedWorkout = workout
		print("Workout selected: \(workout.exerciseName), number of sets: \(workout.numberOfSets), seconds per set: \(workout.secondsPerSet)")
		self.performSegue(withIdentifier: Constants.segue.toOther, sender: self)
	}

	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let OtherViewController = segue.destination as? OtherViewController {
			OtherViewController.selectedWorkout = selectedWorkout
		}
	}



}
