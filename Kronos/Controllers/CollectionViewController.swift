//
//  CollectionViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 06/08/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class CollectionViewController: UICollectionViewController {
	
	let iconsArray = ["attack","acrobatics","barbell","bodybuilder","crossfit","curls-with-dumbbells","dumbbell","foot-angle","gym","gymnastics","jog-forward","jog-reverse","jump-rope","mommy-fitness","parkour","personal-trainer","pilates","prenatal-yoga","running-person","skateboard","spinning","treadmill","walking-simulation","warm-up","workout-2","workout-3","workout","yoga"]
	
	var selectedCell = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource
	
	

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return iconsArray.count
    }
	
	


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
		cell.iconImage.image = UIImage(named: iconsArray[indexPath.row])
		//cell.backgroundColor = UIColor.black
        // Configure the cell
		cell.button.tag = indexPath.row
		cell.button.addTarget(self,
							  action: #selector(tappedOnIcon),
							  for: .touchUpInside)
		
		return cell
    }
	
	@objc func tappedOnIcon(sender: UIButton) {
		print(sender.tag)
		print(iconsArray[sender.tag])
		selectedCell = iconsArray[sender.tag]
		self.performSegue(withIdentifier: Constants.segue.backToNewWorkout, sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let NewWorkoutViewController = segue.destination as? NewWorkoutViewController {
			NewWorkoutViewController.iconButton.setImage(UIImage(named: selectedCell), for: .normal)
			NewWorkoutViewController.imagePicked = selectedCell
		}
	}

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
