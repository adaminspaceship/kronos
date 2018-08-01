//
//  RestWorkoutViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 31/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit

class RestWorkoutViewController: UIViewController {
	
	var setCountLabel = Int()
	var workoutName = String()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		workoutNameField.text = workoutName
		self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
	@IBOutlet weak var workoutNameField: UITextField!
	
	@IBOutlet weak var restSecondsField: UITextField!
	
	override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
			return false
		}
		return true
	}
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let NextNewWorkoutViewController = segue.destination as? NextNewWorkoutViewController {
			NextNewWorkoutViewController.setCountLabel = setCountLabel
			NextNewWorkoutViewController.workoutName = workoutName
			if restSecondsField.text == nil {
				NextNewWorkoutViewController.secondsRest = 3
			} else {
				NextNewWorkoutViewController.secondsRest = Int(restSecondsField.text ?? "30" ) ?? 30
			}
			
		}
	}
	
}
