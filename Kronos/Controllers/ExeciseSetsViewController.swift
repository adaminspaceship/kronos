//
//  ExeciseSetsViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 24/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit



class ExeciseSetsViewController: UIViewController, UITextFieldDelegate {
	
	
//	let secondsOfRestViewController = secondsOfRestViewController()
	
	

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
		exerciseNameField.becomeFirstResponder()
		
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var setCount: UITextField!
	
	@IBOutlet weak var exerciseNameField: UITextField!
	

	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: string)) else {
			return false
		}
		return true
	}

	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let SecondsOfRestViewController = segue.destination as? SecondsOfRestViewController {
			SecondsOfRestViewController.setCountLabel = Int(setCount.text!) ?? 3
			if exerciseNameField.text == "" {
				SecondsOfRestViewController.exerciseName = "Untitled Exercise"
			} else {
				SecondsOfRestViewController.exerciseName = exerciseNameField.text!
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
