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
	@IBOutlet weak var startButtonTapped: UIButton!
	var selectedWorkout = Workout()
    var ringProgressView = RingProgressView()
    let subView = SpringView()
	let setLabel = SpringLabel(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		subView.frame = CGRect(x: view.frame.size.width/2-175, y: view.frame.size.height/2-250, width: 350, height: 350)
        ringProgressView = RingProgressView(frame: CGRect(x: subView.frame.size.width/2-175, y: subView.frame.size.height/2-200, width: 350, height: 350))
		countdownLabel.center = CGPoint(x: view.bounds.size.width/2, y: ringProgressView.bounds.size.height/2+100)
		twoLabel.center = CGPoint(x: view.bounds.size.width/2, y: ringProgressView.bounds.size.height/2+100)
		oneLabel.center = CGPoint(x: view.bounds.size.width/2, y: ringProgressView.bounds.size.height/2+100)
		//set label
		setLabel.center = CGPoint(x: view.center.x, y: ringProgressView.bounds.size.height/2+100)
		setLabel.textAlignment = .center
		setLabel.textColor = UIColor(hex: "F0EEF1")
		setLabel.font = UIFont.systemFont(ofSize: 50, weight: .semibold)
		setLabel.text = "Rest"
		setLabel.numberOfLines = 2
		setLabel.isHidden = true
		self.view.addSubview(setLabel)
		
		let randomValColor = UIColor.red.analagous0
		let randomKeyColor = UIColor.red.analagous1
		ringProgressView.startColor = randomKeyColor
		ringProgressView.endColor = randomValColor
        ringProgressView.ringWidth = 25
        ringProgressView.progress = 0.0
        ringProgressView.backgroundRingColor = UIColor.black
        ringProgressView.shadowOpacity = 0
		view.addSubview(subView)
		subView.addSubview(ringProgressView)
		if randomValColor.isLight {
			startButtonTapped.setTitleColor(.black, for: .normal)
		} else {
			startButtonTapped.setTitleColor(.white, for: .normal)
		}
		startButtonTapped.layer.cornerRadius = 25
		startButtonTapped.setGradientBackground(colorOne: randomKeyColor, colorTwo: randomValColor)
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
						self.animation(duration: Double(self.selectedWorkout.secondsPerSet))
					})
					
				})
			}
		} else {
			
		}
		print(selectedWorkout.secondsPerSet)
	}
	
	
	
	var setsCompleted = 1
	
	
	
    func animation(duration: Double) {
        UIView.animate(withDuration: TimeInterval(duration/20*8),delay: 0,options: .curveLinear , animations: {
            self.ringProgressView.progress = 0.25
        }) { (hello) in
            UIView.animate(withDuration: TimeInterval(duration/20*6),delay: 0,options: .curveLinear, animations: {
                self.ringProgressView.progress = 0.5
            }) {(he) in
                UIView.animate(withDuration: TimeInterval(duration/20*4),delay: 0,options: .curveLinear, animations: {
                    self.ringProgressView.progress = 0.75
                }) {(f) in
                    UIView.animate(withDuration: TimeInterval(duration/20*2),delay: 0,options: .curveLinear, animations: {
                        self.ringProgressView.progress = 1.0
						
					}, completion: {(finished:Bool) in
						self.setLabel.animation = "shake"
						self.setLabel.duration = 10
						self.setLabel.isHidden = false
						self.restAnimation()
						self.setLabel.text = "Rest... Set: \(self.setsCompleted)/\(self.selectedWorkout.numberOfSets)"
						print("Rest... Set: \(self.setsCompleted)/\(self.selectedWorkout.numberOfSets)")
						self.setLabel.animateToNext(completion: {
							self.setsCompleted += 1
							self.setLabel.isHidden = true
							if self.setsCompleted < self.selectedWorkout.numberOfSets {
								self.animation(duration: Double(self.selectedWorkout.secondsPerSet))
								
							} else {
								print("done")
							}
						})
					})
                }
            }
        }
		
    }
	
	
	func restAnimation() {
		UIView.animate(withDuration: 10) {
			self.ringProgressView.progress = 0.0
		}
	}
	
    
}
