//
//  CoreDataHelper.swift
//  Kronos
//
//  Created by Adam Eliezerov on 25/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct CoreDataHelper {
	
	static let context: NSManagedObjectContext = {
		guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
			fatalError()
		}
		
		let persistentContainer = appDelegate.persistentContainer
		let context = persistentContainer.viewContext
		
		return context
	}()
	
	static func newWorkout() -> Workout {
		let workout = NSEntityDescription.insertNewObject(forEntityName: "Workout", into: context) as! Workout
		return workout
	}
	
	static func retrieveWorkouts() -> [Workout] {
		do {
			let fetchRequest = NSFetchRequest<Workout>(entityName: "Workout")
			let results = try context.fetch(fetchRequest)
			
			return results
		} catch let error {
			print("Could not fetch \(error.localizedDescription)")
			
			return []
		}
	}
	static func saveWorkout() {
		do {
			try context.save()
		} catch let error {
			print("Could not save \(error.localizedDescription)")
		}
	}
	static func delete(workout: Workout) {
		context.delete(workout)
		
		saveWorkout()
	}
	
}


