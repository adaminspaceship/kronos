//
//  OtherViewController.swift
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

class OtherViewController: UIViewController, UITextFieldDelegate {
	var selectedExercise = Exercise()
    var ringProgressView = RingProgressView()
	let setLabel = SpringLabel(frame: CGRect(x: 0, y: 0, width: 240, height: 100))
	let UIColorArray = [UIColor.red,UIColor.blue,UIColor.cyan,UIColor.green,UIColor.magenta,UIColor.purple]
	
    override func viewDidLoad() {
        super.viewDidLoad()
        ringProgressView = RingProgressView(frame: CGRect(x: view.frame.size.width/2-175, y: view.frame.size.height/2-200, width: 350, height: 350))
		countdownLabel.center = CGPoint(x: view.bounds.size.width/2, y: ringProgressView.bounds.size.height/2+100)
		twoLabel.center = CGPoint(x: view.bounds.size.width/2, y: ringProgressView.bounds.size.height/2+100)
		oneLabel.center = CGPoint(x: view.bounds.size.width/2, y: ringProgressView.bounds.size.height/2+100)
		//set label
		setLabel.center = CGPoint(x: view.center.x, y: 105)
		setLabel.textAlignment = .center
		setLabel.textColor = UIColor(hex: "474747")
		setLabel.font = UIFont.systemFont(ofSize: 30, weight: .regular)
		setLabel.text = "Get Ready For Set 1/\(selectedExercise.numberOfSets)"
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
		
    }
	@IBOutlet weak var countdownLabel: SpringLabel!
	@IBOutlet weak var twoLabel: SpringLabel!
	
	@IBOutlet weak var oneLabel: SpringLabel!
	
	var started = false
	@IBAction func startButton(_ sender: Any) {
		
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
						self.animation(duration: Double(self.selectedExercise.secondsPerSet))
					})
					
				})
			}
		} else {
			
		}
	}
	
	
	
	var setsCompleted = 1
	var counter: Double = 0
	var didCompleteExercise = false
	
	
    func animation(duration: Double) {
        UIView.animate(withDuration: TimeInterval(duration/20*10),delay: 0,options: .curveLinear , animations: {
            self.ringProgressView.progress = 0.25
        }) { (hello) in
            UIView.animate(withDuration: TimeInterval(duration/20*6),delay: 0,options: .curveLinear, animations: {
                self.ringProgressView.progress = 0.5
            }) {(he) in
                UIView.animate(withDuration: TimeInterval(duration/20*4),delay: 0,options: .curveLinear, animations: {
                    self.ringProgressView.progress = 0.75
                }) {(f) in
                    UIView.animate(withDuration: TimeInterval(duration/20*4),delay: 0,options: .curveLinear, animations: {
                        self.ringProgressView.progress = 1.0
						
					}, completion: {(finished:Bool) in
						self.setLabel.duration = CGFloat(self.selectedExercise.restTime)
						self.setLabel.isHidden = false
						if self.didCompleteExercise == true {
							self.setLabel.text = "Done"
							return
						} else {
							self.restAnimation()
						}
						self.setLabel.text = "Rest... Get Ready For Set: \(self.setsCompleted+1)/\(self.selectedExercise.numberOfSets)"
						print("Get Ready For Set: \(self.setsCompleted+1)/\(self.selectedExercise.numberOfSets)")
						self.setLabel.animateToNext(completion: {
							self.setLabel.isHidden = true
							if self.setsCompleted < self.selectedExercise.numberOfSets-1 {
								self.animation(duration: Double(self.selectedExercise.secondsPerSet))
								self.setsCompleted += 1
							} else {
								if self.didCompleteExercise == false {
									self.didCompleteExercise = true
									self.animation(duration: Double(self.selectedExercise.secondsPerSet))
								} else {
									self.setLabel.isHidden = false
									self.setLabel.text = "Done"
								}
							}
						})
					})
                }
            }
        }
		
    }
	
	
	func restAnimation() {
		UIView.animate(withDuration: TimeInterval(selectedExercise.restTime)) {
			self.ringProgressView.progress = 0.0
		}
	}
	
    
}
