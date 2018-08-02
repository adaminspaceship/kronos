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
	
	var workouts = [Workouts]()
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return workouts.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "workoutCell") as! WorkoutTableViewCell
		let workout = workouts[indexPath.row]
		cell.workoutNameLabel.text = workout.workoutName
		return cell
	}
	

	
	override func viewDidLoad() {
        super.viewDidLoad()
		workouts = CoreDataHelper.retrieveWorkouts()
        // Do any additional setup after loading the view.
		let newWorkout = CoreDataHelper.newWorkout()
		newWorkout.workoutName = "Core"
		CoreDataHelper.saveWorkout()
		
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
