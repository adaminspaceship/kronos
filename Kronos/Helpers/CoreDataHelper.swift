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
	
	// exercises
	
	static func newExercise() -> Exercise {
		let exercise = NSEntityDescription.insertNewObject(forEntityName: "Exercise", into: context) as! Exercise
		return exercise
	}
	
	static func retrieveExercises() -> [Exercise] {
		do {
			let fetchRequest = NSFetchRequest<Exercise>(entityName: "Exercise")
			let results = try context.fetch(fetchRequest)
			
			return results
		} catch let error {
			print("Could not fetch \(error.localizedDescription)")
			
			return []
		}
	}
	static func saveExercise() {
		do {
			try context.save()
		} catch let error {
			print("Could not save \(error.localizedDescription)")
		}
	}
	static func delete(exercise: Exercise) {
		context.delete(exercise)
		
		saveExercise()
	}
	
	// workouts
	
	static func newWorkout() -> Workouts {
		let exercise = NSEntityDescription.insertNewObject(forEntityName: "Workouts", into: context) as! Workouts
		return exercise
	}
	
	static func retrieveWorkouts() -> [Workouts] {
		do {
			let fetchRequest = NSFetchRequest<Workouts>(entityName: "Workouts")
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
	static func delete(workouts: Workouts) {
		context.delete(workouts)
		
		saveExercise()
	}
	
}


