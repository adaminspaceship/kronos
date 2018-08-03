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
	
	var analagous0: UIColor {
		return self.withHueOffset(offset: -1 / 12)
	}
	var analagous1: UIColor {
		return self.withHueOffset(offset: 1 / 12)
	}
	func withHueOffset(offset: CGFloat) -> UIColor {
		var h: CGFloat = 0
		var s: CGFloat = 0
		var b: CGFloat = 0
		var a: CGFloat = 0
		self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
		return UIColor(hue: fmod(h + offset, 1), saturation: s, brightness: b, alpha: a)
	}
}

extension UIViewController {
	func hideKeyboardWhenTappedAround() {
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}
	
	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}

