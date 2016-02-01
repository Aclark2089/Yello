//
//  SwitchCell.swift
//  Yelp
//
//  Created by Alex Clark on 1/31/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {
    
    @IBOutlet var switchLabel: UILabel!
    @IBOutlet var onSwitch: UISwitch!
    
    weak var delegate: SwitchCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        onSwitch.addTarget(self, action: "switchValueChanged", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func switchValueChanged() {
        print("Switch value was changed")
        
        // Call delegate
        delegate?.switchCell?(self, didChangeValue: onSwitch.on)

    }

}
