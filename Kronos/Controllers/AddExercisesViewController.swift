//
//  AddExercisesViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 02/08/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit
import Spring
import CoreData

class AddExercisesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	var exercises = ["Untitled Exercise"]
	
	@IBOutlet weak var tableView: UITableView!
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return exercises.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ExerciseTableViewCell
		cell.exerciseNameField.placeholder = exercises[indexPath.row]
		return cell
	}
	
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			self.exercises.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	

    override func viewDidLoad() {
        super.viewDidLoad()
		tableView.rowHeight = 80
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBOutlet weak var addExerciseButton: SpringButton!
	
	@IBAction func addExerciseButtonTapped(_ sender: Any) {
		self.exercises.append("Untitled Exercise")
		self.tableView.beginUpdates()
		self.tableView.insertRows(at: [IndexPath.init(row: self.exercises.count-1, section: 0)], with: .fade)
		self.tableView.endUpdates()
		let indexPath = IndexPath(row: self.exercises.count-1, section: 0)
		self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
		
	}
	@IBAction func doneButtonTapped(_ sender: Any) {
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
