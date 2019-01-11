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
import AVFoundation

class TimerViewController: UIViewController, UITextFieldDelegate {
	
	@IBOutlet weak var navBarTitle: UINavigationItem!
	
	var selectedWorkoutName = String()
	var secondsTime = Int16()
	
    var ringProgressView = RingProgressView()
	let setLabel = SpringLabel(frame: CGRect(x: 0, y: 0, width: 240, height: 100))
	let UIColorArray = [UIColor.red,UIColor.blue,UIColor.cyan,UIColor.green,UIColor.magenta,UIColor.purple]

    override func viewDidLoad() {
        super.viewDidLoad()
		startButton.isHidden = false
        ringProgressView = RingProgressView(frame: CGRect(x: view.frame.size.width/2-175, y: view.frame.size.height/2-200, width: 350, height: 350))
		countdownLabel.center = CGPoint(x: view.bounds.size.width/2, y: ringProgressView.bounds.size.height/2+100)
		twoLabel.center = CGPoint(x: view.bounds.size.width/2, y: ringProgressView.bounds.size.height/2+100)
		oneLabel.center = CGPoint(x: view.bounds.size.width/2, y: ringProgressView.bounds.size.height/2+100)
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

	@IBOutlet var popOver: SpringView!
	@IBOutlet weak var countdownLabel: SpringLabel!
	@IBOutlet weak var twoLabel: SpringLabel!
	@IBOutlet weak var oneLabel: SpringLabel!
	@IBOutlet weak var startButton: UIButton!
	
	var started = false
	@IBAction func startButton(_ sender: Any) {
	AudioServicesPlaySystemSound(1519)
	startButton.isHidden = true
	if started == false {
			countdownLabel.animation = "squeezeDown"
			countdownLabel.duration = 1
			countdownLabel.animateNext {
				self.countdownLabel.isHidden = true
				self.twoLabel.animation = "squeezeDown"
				self.twoLabel.duration = 1
				self.twoLabel.animateNext(completion: {
					self.twoLabel.isHidden = true
					self.oneLabel.animation = "squeezeDown"
					self.oneLabel.duration = 1
					self.oneLabel.animate()
					self.oneLabel.animateNext(completion: {
						self.oneLabel.isHidden = true
						self.setLabel.isHidden = true
						// start timer animation
						self.animation(duration: Double(self.secondsTime), exerciseName: self.selectedWorkoutName)
					})

				})
			}
		}
		
	}

	func animation(duration: Double, exerciseName: String) {
		//navBarTitle.title = exerciseName
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
						//done
						self.didFinishTimer()
					})
                }
            }
        }
    }
	
	var objPlayer: AVAudioPlayer?
	func didFinishTimer() {
		playAudio()
		// dim background
		self.navigationController?.navigationBar.alpha = 0.5
		ringProgressView.alpha = 0.5
		self.view?.backgroundColor = UIColor(white: 1, alpha: 0.5)
		AudioServicesPlaySystemSound(1520) // Actuate "Nope" feedback (series of three weak booms)
		popOver.center.x = self.view.center.x
		popOver.center.y = self.view.center.y+170
		self.popOver.alpha = 1
		self.view.addSubview(popOver)
		popOver.animation = "slideUp"
		popOver.y = -1000
		popOver.animate()
		
	}
	@IBAction func stopAudio(_ sender: Any) {
		objPlayer!.stop()
		AudioServicesPlaySystemSound(1519)
		// undim background
		self.navigationController?.navigationBar.alpha = 1
		ringProgressView.alpha = 1
		self.view?.backgroundColor = UIColor(white: 1, alpha: 1)
	}
	
	func playAudio() {
		guard let url = Bundle.main.url(forResource: "ringtone", withExtension: "mp3") else { return }
		
		do {
			try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
			try AVAudioSession.sharedInstance().setActive(true)
			
			// For iOS 11
			objPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
			
			// For iOS versions < 11
			objPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
			
			guard let aPlayer = objPlayer else { return }
			aPlayer.play()
			aPlayer.numberOfLoops = -1
		} catch let error {
			print(error.localizedDescription)
		}
	}
	


}
