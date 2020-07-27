//
//  NoneCompleteTableCell.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 23/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import UIKit

class NoneCompleteTableCell: UITableViewCell {

    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(dateString: String) {
        self.lblDate.text = dateString
    }

}
