//
//  WorkoutTableViewCell.swift
//  Kronos
//
//  Created by Adam Eliezerov on 02/08/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		backgroundCardView.layer.cornerRadius = 25
		backgroundCardView.layer.masksToBounds = false
		
		backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
		backgroundCardView.layer.shadowOpacity = 0.8
		backgroundCardView.layer.shadowOffset = CGSize(width: 1.5, height: 3)
		
    }
	@IBOutlet weak var backgroundCardView: UIView!
	@IBOutlet weak var workoutIconImage: UIImageView!
	
	@IBOutlet weak var workoutNameLabel: UILabel!
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		if selected == true {
			self.backgroundCardView.backgroundColor = UIColor.gray
		} else {
			self.backgroundCardView.backgroundColor = UIColor.white
		}
		
		// Configure the view for the selected state
	}

}
