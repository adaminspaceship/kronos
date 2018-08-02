//
//  SecondsOfRestViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 31/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit

class SecondsOfRestViewController: UIViewController {
	
	var setCountLabel = Int()
	var exerciseName = String()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		exerciseNameField.text = exerciseName
		self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
		let border = CALayer()
		let width = CGFloat(2.0)
		border.borderColor = UIColor.darkGray.cgColor
		border.frame = CGRect(x: 0, y: restSecondsField.frame.size.height - width, width: restSecondsField.frame.size.width, height: restSecondsField.frame.size.height)
		
		border.borderWidth = width
		restSecondsField.layer.addSublayer(border)
		restSecondsField.layer.masksToBounds = true
    }
	
	@IBOutlet weak var exerciseNameField: UITextField!
	
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
		if let SecondsPerSetViewController = segue.destination as? SecondsPerSetViewController {
			SecondsPerSetViewController.setCountLabel = setCountLabel
			SecondsPerSetViewController.exerciseName = exerciseName
			if restSecondsField.text == nil {
				SecondsPerSetViewController.secondsRest = 3
			} else {
				SecondsPerSetViewController.secondsRest = Int(restSecondsField.text ?? "30" ) ?? 30
			}
			
		}
	}
	
}
