//
//  AddressesCell.swift
//  Abaya
//
//  Created by Rajendra Kumar on 10/04/19.
//  Copyright © 2019 Kareem Mohammed. All rights reserved.
//

import UIKit

class AddressesCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblAddress1: UILabel!
    @IBOutlet weak var lblAddress2: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var imgTickMark: UIImageView!
    @IBOutlet weak var btnCheckMark: UIButton!
    @IBOutlet weak var viewLineBottom: UIView!
    
    @IBOutlet weak var viewBottom: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
