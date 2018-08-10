//
//  SettingsTableViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 10/08/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	@IBAction func rateOnAppstoreTapped(_ sender: Any) {
		UIApplication.shared.open(URL(string : "https://itunes.apple.com/us/app/kronos-workout-app/id1423453446?mt=8&action=write-review")!, options: [:], completionHandler: { (status) in
		})
	}
	
	@IBAction func sendEmailButtonTapped(_ sender: Any) {
		let link = "mailto:adam.eliezerov@gmail.com"
		UIApplication.shared.open(URL(string : link)!, options: [:], completionHandler: { (status) in
			
		})
	}

	
}
