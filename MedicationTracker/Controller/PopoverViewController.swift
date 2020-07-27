//
//  PopoverViewController.swift
//  MedicationTracker
//
//  Created by Sushree Swagatika on 25/07/20.
//  Copyright © 2020 Sushree Swagatika. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    @IBOutlet var tblDropdown: UITableView!
    
    var selectedIndexRow = -1
    
    var widthConstraintValue: CGFloat = 120
    var heightConstraintValue: CGFloat = 114

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.widthAnchor.constraint(
            equalToConstant: widthConstraintValue
        ).isActive = true
        self.view.heightAnchor.constraint(
            equalToConstant: heightConstraintValue
        ).isActive = true
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let contentSize = self.view.systemLayoutSizeFitting(
            UIView.layoutFittingCompressedSize
        )
        self.preferredContentSize = contentSize
        self.popoverPresentationController?.presentedViewController.preferredContentSize = contentSize
    }
    
    // MARK: - private methods
    
    private func reloadTable() {
        DispatchQueue.main.async {
            self.tblDropdown.reloadData()
        }
    }

}

// MARK: - UITableViewMethods
extension PopoverViewController: UITableViewMethods {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SupportingTimings.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.DropdownCellIdentifier.rawValue) as! PopoverTableCell
        
        var isSelected = false
        if indexPath.row == selectedIndexRow {
            isSelected = true
        }
        let item = SupportingTimings.allCases[indexPath.row]
        cell.configure(withText: item.title, isSelected: isSelected)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndexRow = indexPath.row
        reloadTable()
        
        let selectedTimingItem = SupportingTimings.allCases[indexPath.row]

        NotificationCenter.default.post(name: .showAlert, object: self, userInfo: ["type":selectedTimingItem.code])
        
        self.dismiss(animated: true, completion: nil)
    }
}
