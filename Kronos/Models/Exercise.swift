//
//  Exercise.swift
//  Kronos
//
//  Created by Adam Eliezerov on 02/08/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit

public class Exercise: NSObject {
	
	var exerciseName = String()
	var secondsPerSet = Int()
	
	
	init(exerciseName: String, secondsPerSet: Int) {
		self.exerciseName = exerciseName
		self.secondsPerSet = secondsPerSet
	}
	
}
