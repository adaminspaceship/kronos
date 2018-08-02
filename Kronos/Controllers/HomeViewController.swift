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

	
	var exercises = [Exercise]()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		tableView.rowHeight = 80
		
		
    }
	override func viewDidAppear(_ animated: Bool) {
		exercises = CoreDataHelper.retrieveExercises()
		tableView.reloadData()
		
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
		return exercises.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
		cell.exerciseLabel.text = exercises[indexPath.row].exerciseName
		let exercise = exercises[indexPath.row]
		cell.secondLabel.text = "\(exercise.secondsPerSet) seconds"
		cell.numberOfSetsLabel.text = "\(exercise.numberOfSets) sets"
		return cell
	}
	var selectedExercise = Exercise()
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let exercise = exercises[indexPath.row]
		selectedExercise = exercise
		print("Exercise selected: \(exercise.exerciseName), number of sets: \(exercise.numberOfSets), seconds per set: \(exercise.secondsPerSet), rest per set: \(exercise.restTime)")
		self.performSegue(withIdentifier: Constants.segue.toOther, sender: self)
		
	}
	
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
		return true
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let exerciseToDelete = exercises[indexPath.row]
			CoreDataHelper.delete(exercise: exerciseToDelete)
			
			exercises = CoreDataHelper.retrieveExercises()
			tableView.reloadData()
		}
	}

	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let OtherViewController = segue.destination as? OtherViewController {
			OtherViewController.selectedExercise = selectedExercise
		}
	}



}
