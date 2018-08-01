//
//  TableViewCell.swift
//  Kronos
//
//  Created by Adam Eliezerov on 25/07/2018.
//  Copyright © 2018 adameliezerov. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		contentView.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)
		backgroundCardView.layer.cornerRadius = 3.0
		backgroundCardView.layer.masksToBounds = false
		
		backgroundCardView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
		backgroundCardView.layer.shadowOpacity = 0.8
		backgroundCardView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
	@IBOutlet weak var exerciseLabel: UILabel!
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
		if selected == true {
			self.backgroundCardView.backgroundColor = UIColor.gray
		} else {
			self.backgroundCardView.backgroundColor = UIColor.white
		}
		
        // Configure the view for the selected state
    }
	@IBOutlet weak var secondLabel: UILabel!
	@IBOutlet weak var backgroundCardView: UIView!
	
	@IBOutlet weak var numberOfSetsLabel: UILabel!
}
