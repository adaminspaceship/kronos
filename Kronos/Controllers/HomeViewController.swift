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
	
	var selectedWorkout = String()
	var exercisesForSelectedWorkout = [String:Int]()
	let userDefaults = UserDefaults.standard
	var selectedWorkoutRestTime = Int()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		tableView.rowHeight = 80
		
    }
	override func viewDidAppear(_ animated: Bool) {
		exercisesForSelectedWorkout = userDefaults.dictionary(forKey: selectedWorkout) as! [String : Int]
		tableView.reloadData()
	}
	
	
	@IBAction func startWorkoutButtonTapped(_ sender: Any) {
		self.performSegue(withIdentifier: Constants.segue.toOther, sender: self)
	}
	
	override func viewDidDisappear(_ animated: Bool) {
		super.viewDidDisappear(animated)
		guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
		tableView.deselectRow(at: selectedIndexPath, animated: false)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBOutlet weak var tableView: UITableView!
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return exercisesForSelectedWorkout.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
		let key = [String](exercisesForSelectedWorkout.keys)[indexPath.row]
		let value = exercisesForSelectedWorkout[key]
		cell.exerciseLabel.text = key
		cell.secondLabel.text = "\(value ?? 60) seconds"
		return cell
	}

	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let key = [String](exercisesForSelectedWorkout.keys)[indexPath.row]
			exercisesForSelectedWorkout.removeValue(forKey: key)
			userDefaults.set(exercisesForSelectedWorkout, forKey: key)
			userDefaults.synchronize()
			tableView.reloadData()
		}
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let OtherViewController = segue.destination as? TimerViewController {
			OtherViewController.selectedWorkout = selectedWorkout
			OtherViewController.selectedWorkoutRestTime = selectedWorkoutRestTime
			OtherViewController.selectedExercises = exercisesForSelectedWorkout
		}

	}




}
