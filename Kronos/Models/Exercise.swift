//
//  Exercise.swift
//  Kronos
//
//  Created by Adam Eliezerov on 03/08/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit
import CoreData

public class Exercise: NSManagedObject,NSCoding {
	
	
	public required convenience init?(coder aDecoder: NSCoder) {
		self.init(coder: aDecoder)
		self.exerciseName = (aDecoder.decodeObject(forKey: "exerciseName") as? String)!
		self.secondsPerSet = (aDecoder.decodeObject(forKey: "secondsPerSet") as? Int)!
	}
	
	
	
	public func encode(with aCoder: NSCoder) {
		aCoder.encode(self.exerciseName, forKey: "exerciseName")
		aCoder.encode(self.secondsPerSet, forKey: "secondsPerSet")
	}
	
	var exerciseName = String()
	var secondsPerSet = Int()
	
	
//	init(exerciseName: String, secondsPerSet: Int) {
//		self.exerciseName = exerciseName
//		self.secondsPerSet = secondsPerSet
//	}
	

}
