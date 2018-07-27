//
//  UIView+Extension.swift
//  Kronos
//
//  Created by Adam Eliezerov on 26/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
	
	func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.frame = bounds
		gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
		gradientLayer.locations = [0.0, 1.0]
		gradientLayer.startPoint = CGPoint(x: 1.0, y: 1.0)
		gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
		gradientLayer.cornerRadius = 25
		layer.insertSublayer(gradientLayer, at: 0)
	}
}

extension UIColor {
	var isLight: Bool {
		var white: CGFloat = 0
		getWhite(&white, alpha: nil)
		return white > 0.5
	}
}

