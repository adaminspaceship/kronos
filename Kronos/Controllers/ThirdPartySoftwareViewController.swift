//
//  ThirdPartySoftwareViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 10/08/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit

class ThirdPartySoftwareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func github0(_ sender: Any) {
		goToLink(url: "https://github.com/maxkonovalov/MKRingProgressView")
	}
	@IBAction func github1(_ sender: Any) {
		goToLink(url: "https://github.com/yeahdongcn/UIColor-Hex-Swift")
	}
	
	@IBAction func github2(_ sender: Any) {
		goToLink(url: "https://github.com/MengTo/Spring")
	}
	
	
	func goToLink(url: String) {
		UIApplication.shared.open(URL(string : url)!, options: [:], completionHandler: { (status) in
		})
	}
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
	
}
