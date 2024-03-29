//
//  SliderCell.swift
//  FacilityManagement
//
//  Created by Unify Systems on 13/09/18.
//  Copyright © 2018 Unify Systems. All rights reserved.
//

import UIKit

class SliderCell: UITableViewCell {

    @IBOutlet var detailsLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet weak var arrowImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let imageA = UIImage(named: NSLocalizedString("Arrow", comment: ""))
        arrowImage.image = imageA
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
