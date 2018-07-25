//
//  OtherViewController.swift
//  Kronos
//
//  Created by Adam Eliezerov on 23/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit
import MKRingProgressView

class OtherViewController: UIViewController {
    
    var ringProgressView = RingProgressView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ringProgressView = RingProgressView(frame: CGRect(x: view.frame.size.width/2-175, y: view.frame.size.height/2-300, width: 350, height: 350))
        
        ringProgressView.startColor = .black
        ringProgressView.endColor = .red
        ringProgressView.ringWidth = 10
        ringProgressView.progress = 0.0
        ringProgressView.style = .round
        ringProgressView.shadowOpacity = 0
        view.addSubview(ringProgressView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
        
    }
    
    
    func animation(duration: Double) {
        UIView.animate(withDuration: TimeInterval(duration/20*7.5),delay: 0,options: .curveLinear , animations: {
            self.ringProgressView.progress = 0.25
        }) { (hello) in
            UIView.animate(withDuration: TimeInterval(duration/20*6.25),delay: 0,options: .curveLinear, animations: {
                self.ringProgressView.progress = 0.5
            }) {(he) in
                UIView.animate(withDuration: TimeInterval(duration/20*3.75),delay: 0,options: .curveLinear, animations: {
                    self.ringProgressView.progress = 0.75
                }) {(f) in
                    UIView.animate(withDuration: TimeInterval(duration/20*2.5),delay: 0,options: .curveLinear, animations: {
                        self.ringProgressView.progress = 1.0
                    })
                }
            }
        }
        
        
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let button = sender as? UIButton else {
            return
        }
        animation(duration: Double(button.tag))
        

    }
    
}
