//
//  TimerViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 23/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit
import MKRingProgressView
import CoreData
import UIColor_Hex_Swift
import Spring

class TimerViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var navBarTitle: UINavigationItem!
	
	var selectedExercises = [String:Int]()
	var selectedWorkout = String()
	var selectedWorkoutRestTime = Int()
    var ringProgressView = RingProgressView()
	let setLabel = SpringLabel(frame: CGRect(x: 0, y: 0, width: 240, height: 100))
	let UIColorArray = [UIColor.red,UIColor.blue,UIColor.cyan,UIColor.green,UIColor.magenta,UIColor.purple]

    override func viewDidLoad() {
        super.viewDidLoad()
		presentAlert()
		startButton.isHidden = false
        ringProgressView = RingProgressView(frame: CGRect(x: view.frame.size.width/2-175, y: view.frame.size.height/2-200, width: 350, height: 350))
		countdownLabel.center = CGPoint(x: view.bounds.size.width/2, y: ringProgressView.bounds.size.height/2+100)
		twoLabel.center = CGPoint(x: view.bounds.size.width/2, y: ringProgressView.bounds.size.height/2+100)
		oneLabel.center = CGPoint(x: view.bounds.size.width/2, y: ringProgressView.bounds.size.height/2+100)
		//set label
		setLabel.center = CGPoint(x: view.center.x, y: view.center.y)
		setLabel.textAlignment = .center
		setLabel.textColor = UIColor(hex: "474747")
		setLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
//		setLabel.text = "Get Ready For Set 1/\(selectedExercise.numberOfSets)"
		setLabel.numberOfLines = 3
		setLabel.isHidden = false
		self.view.addSubview(setLabel)
		let randomColor = UIColorArray[Int(arc4random_uniform(UInt32(UIColorArray.count)))]
		let randomValColor = randomColor.analagous0
		let randomKeyColor = randomColor.analagous1
		ringProgressView.startColor = randomKeyColor
		ringProgressView.endColor = randomValColor
        ringProgressView.ringWidth = 25
        ringProgressView.progress = 0.0
		ringProgressView.backgroundRingColor = UIColor(hex: "#474747")
        ringProgressView.shadowOpacity = 0
		DispatchQueue.main.async {
			self.view.addSubview(self.ringProgressView)

		}


    }
	
	var setsSelected = 3
	
	func presentAlert() {
		let alert = UIAlertController(title: "How Many Sets?", message: "", preferredStyle: .alert)
		
		alert.addTextField { (textField) in
			textField.text = "3"
		}
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
			let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
			self.setsSelected = Int((textField?.text) ?? "3") ?? 3
		}))
		self.present(alert, animated: true, completion: nil)
	}
	
	
	func startWorkout() {
		if let excerciseKeyValuePair = selectedExercises.first {
			let exerciseName = excerciseKeyValuePair.key
			let exerciseDuration = excerciseKeyValuePair.value
			
			self.animation(duration: Double(exerciseDuration), exerciseName: exerciseName) {
				self.selectedExercises.removeValue(forKey: exerciseName)
				self.startWorkout()
			}
			
		} else {
			 setLabel.text = "Done!"
		}
	}

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
	@IBOutlet weak var countdownLabel: SpringLabel!
	@IBOutlet weak var twoLabel: SpringLabel!
	@IBOutlet weak var oneLabel: SpringLabel!
	@IBOutlet weak var startButton: UIButton!
	
	var started = false
	@IBAction func startButton(_ sender: Any) {
	
	startButton.isHidden = true
	if started == false {
			countdownLabel.animation = "squeezeDown"
			countdownLabel.duration = 1.5
			countdownLabel.animateNext {
				self.countdownLabel.isHidden = true
				self.twoLabel.animation = "squeezeDown"
				self.twoLabel.duration = 1.5
				self.twoLabel.animateNext(completion: {
					self.twoLabel.isHidden = true
					self.oneLabel.animation = "squeezeDown"
					self.oneLabel.duration = 1.3
					self.oneLabel.animate()
					self.oneLabel.animateNext(completion: {
						self.oneLabel.isHidden = true
						self.setLabel.isHidden = true
						self.startWorkout()
					})

				})
			}
		} else {
		
	}
		
	}



	var setsCompleted = 1
	var didCompleteExercise = false


	func animation(duration: Double,exerciseName: String, completion: @escaping () -> Void) {
		navBarTitle.title = exerciseName
		print("duration: \(duration), exercise name: \(exerciseName)")
		UIView.animate(withDuration: TimeInterval(selectedWorkoutRestTime), delay: 0, options: .curveEaseIn, animations: {
			self.ringProgressView.progress = 0
		}) { (n) in
        UIView.animate(withDuration: TimeInterval(duration/20*10),delay: 0,options: .curveLinear , animations: {
            self.ringProgressView.progress = 0.25
        }) { (hello) in
            UIView.animate(withDuration: TimeInterval(duration/20*6),delay: 0,options: .curveLinear, animations: {
                self.ringProgressView.progress = 0.5
            }) {(he) in
                UIView.animate(withDuration: TimeInterval(duration/20*5),delay: 0,options: .curveLinear, animations: {
                    self.ringProgressView.progress = 0.75
                }) {(f) in
                    UIView.animate(withDuration: TimeInterval(duration/20*3),delay: 0,options: .curveLinear, animations: {
                        self.ringProgressView.progress = 1.0
					}, completion: {(finished:Bool) in
						self.setLabel.duration = CGFloat(self.selectedWorkoutRestTime)
						self.setLabel.isHidden = false
						if self.didCompleteExercise == true {
							self.setLabel.text = "Done!"
						} else {
							self.restAnimation()
						}
						self.setLabel.text = "Rest... Get Ready For Set: \(self.setsCompleted+1)/\(self.setsSelected)"
						print("Get Ready For Set: \(self.setsCompleted+1)/\(self.setsSelected)")
						self.setLabel.animateToNext(completion: {
							self.setLabel.isHidden = true
							if self.setsCompleted < self.setsSelected {
								self.setsCompleted += 1
								self.animation(duration: duration, exerciseName: exerciseName, completion: completion)
								
							} else {
								if self.didCompleteExercise == false {
									self.didCompleteExercise = true
									self.animation(duration: duration, exerciseName: exerciseName, completion: completion)
									self.setLabel.text = "Rest... Get Ready For Set: \(self.setsCompleted+1)/\(self.setsSelected)"
								} else {
									self.setLabel.isHidden = false
									self.setLabel.text = "Rest... Get Ready For Set: \(self.setsCompleted+1)/\(self.setsSelected)"
									self.setsCompleted = 1
									self.didCompleteExercise = false
									completion()
								}
							}
						})
					})
                }
            }
        }
		}

    }


	func restAnimation() {
		UIView.animate(withDuration: TimeInterval(selectedWorkoutRestTime)) {
			self.ringProgressView.progress = 0.0
			print(self.selectedWorkoutRestTime)
		}
	}


}
