//
//  SecondsPerSetViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 24/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit
import CoreData

class SecondsPerSetViewController: UIViewController {
	
	var setCountLabel = Int()
	var exerciseName = String()
	var secondsRest = Int()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		exerciseNameField.text = exerciseName
		self.hideKeyboardWhenTappedAround()
		secondsPerSetField.becomeFirstResponder()
		
		let border = CALayer()
		let width = CGFloat(2.0)
		border.borderColor = UIColor.darkGray.cgColor
		border.frame = CGRect(x: 0, y: secondsPerSetField.frame.size.height - width, width: secondsPerSetField.frame.size.width, height: secondsPerSetField.frame.size.height)
		
		border.borderWidth = width
		secondsPerSetField.layer.addSublayer(border)
		secondsPerSetField.layer.masksToBounds = true
		
    }
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
			return false
		}
		return true
	}

	
	@IBOutlet weak var secondsPerSetField: UITextField!
	
	@IBOutlet weak var exerciseNameField: UITextField!
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
    
	@IBAction func doneButtonTapped(_ sender: Any) {

		let exercise = CoreDataHelper.newExercise()
		exercise.exerciseName = exerciseName
		exercise.numberOfSets = Int32(setCountLabel)
		exercise.secondsPerSet = Int32(secondsPerSetField.text ?? "60") ?? 60
		exercise.restTime = Int32(secondsRest)
		CoreDataHelper.saveExercise()
		
	}



}
