//
//  TabViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 06/08/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit
import Tabman
import Pageboy

class MainTabViewController: TabmanViewController, PageboyViewControllerDataSource {
	
	var viewControllers = [UIViewController]()
	
	func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
		return viewControllers.count
	}
	
	func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
		return viewControllers[index]
	}
	
	func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
		return nil
	}
	
	

    override func viewDidLoad() {
        super.viewDidLoad()
		self.dataSource = self
		
		// configure the bar
		self.bar.items = [Item(title: "Page 1"), Item(title: "Page 2")]
		self.bar.style = .bar
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let viewController = storyboard.instantiateViewController(withIdentifier: "WorkoutsViewController") as! WorkoutsViewController
		viewControllers.append(viewController)
		self.reloadPages()
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

