//
//  NewWorkoutViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 24/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit



class NewWorkoutViewController: UIViewController, UITextFieldDelegate {
	
	
	let nextWorkoutController = NextNewWorkoutViewController()
	
	

    override func viewDidLoad() {
        super.viewDidLoad()
		
        // Do any additional setup after loading the view.
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: setCount.frame.size.height - width, width: setCount.frame.size.width, height: setCount.frame.size.height)
        
        border.borderWidth = width
        setCount.layer.addSublayer(border)
        setCount.layer.masksToBounds = true
        self.hideKeyboardWhenTappedAround()
		workoutNameField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var setCount: UITextField!
    
	@IBOutlet weak var workoutNameField: UITextField!

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
			return false
		}
		return true
	}

	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let NextNewWorkoutViewController = segue.destination as? NextNewWorkoutViewController {
			NextNewWorkoutViewController.setCountLabel = Int(setCount.text!) ?? 3
			if workoutNameField.text == "" {
				NextNewWorkoutViewController.workoutName = "Untitled Workout"
			} else {
				NextNewWorkoutViewController.workoutName = workoutNameField.text!
			}
			
		}
	}
	
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
