//
//  ViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 23/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let gradient = CAGradientLayer()
//        gradient.frame = self.watchHandView.bounds
//        gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
//        self.watchHandView.layer.insertSublayer(gradient, at: 0)
    }
    

    @IBOutlet weak var watchHandView: UIView!
    override func viewDidAppear(_ animated: Bool) {
        self.watchHandView.setAnchorPoint(CGPoint(x: 0.5, y: 1))
        
        UIView.animate(withDuration: 10) {
            let angle =  CGFloat.pi/2
            let tr = CGAffineTransform.identity.rotated(by: angle)
            
            self.watchHandView.transform = tr
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
}
