//
//  AllCompleteTableCell.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 23/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import UIKit

class AllCompleteTableCell: UITableViewCell {

    @IBOutlet var lblMornTime: UILabel!
    @IBOutlet var lblAftnTime: UILabel!
    @IBOutlet var lblEvngTime: UILabel!
    
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
    
    public func configure(morning: String, afternoon: String, evening: String, dateString: String) {
        self.lblMornTime.text = morning
        self.lblAftnTime.text = afternoon
        self.lblEvngTime.text = evening
        
        self.lblDate.text = dateString
    }

}
