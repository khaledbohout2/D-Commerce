//
//  AccountCell.swift
//
//  Created by Unify Systems on 13/09/18.
//  Copyright © 2018 Unify Systems. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var flagImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
