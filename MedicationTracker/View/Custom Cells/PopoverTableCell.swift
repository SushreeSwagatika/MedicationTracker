//
//  PopoverTableCell.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 25/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import UIKit

class PopoverTableCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(withText text: String, isSelected: Bool) {
        self.textLabel?.text = text
        
        if isSelected {
            self.backgroundColor = UIColor(named: "greenMedicationColor")?.withAlphaComponent(0.2)
            self.textLabel?.textColor = UIColor(named: "greenMedicationColor")
        } else {
            self.backgroundColor = .white
            self.textLabel?.textColor = .black
        }
    }

}
