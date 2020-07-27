//
//  SomeCompleteTableCell.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 23/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import UIKit

class SomeCompleteTableCell: UITableViewCell {

    @IBOutlet var lblType1: UILabel!
    @IBOutlet var lblTime1: UILabel!
    
    @IBOutlet var lblType2: UILabel!
    @IBOutlet var lblTime2: UILabel!
    
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

    public func configure(array: [[String:String]], dateString: String, score: String) {
        if array.count > 1 {
            let dict1 = array[0]
            self.lblType1.text = dict1.keys.first
            self.lblTime1.text = dict1.values.first
            
            let dict2 = array[1]
            self.lblType2.text = dict2.keys.first
            self.lblTime2.text = dict2.values.first
        }
        else {
            let dict1 = array[0]
            self.lblType1.text = dict1.keys.first
            self.lblTime1.text = dict1.values.first
        }
        
        self.lblDate.text = dateString
        self.lblScore.text = score
    }
}
