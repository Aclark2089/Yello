//
//  BusinessCell.swift
//  Yelp
//
//  Created by Alex Clark on 1/26/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking


class BusinessCell: UITableViewCell {

    // Outlets
    
    @IBOutlet var thumbImageView: UIImageView!
    @IBOutlet var ratingImageView: UIImageView!
    
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var reviewsCountLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var catagoriesLabel: UILabel!
    
    
    var business: Business! {
        didSet {
            nameLabel.text = business.name
            thumbImageView.setImageWithURL(business.imageURL!)
            catagoriesLabel.text = business.categories
            addressLabel.text = business.address
            reviewsCountLabel.text = "\(business.reviewCount!) Reviews"
            ratingImageView.setImageWithURL(business.ratingImageURL!)
            distanceLabel.text = business.distance
            print(business.imageURL)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
