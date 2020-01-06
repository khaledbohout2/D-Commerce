//
//  OrderItemCell.swift
//  Abaya
//
//  Created by Khaled Bohout on 12/6/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit

class OrderItemCell: UITableViewCell {
    
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var ProductPrice: UILabel!
    
    @IBOutlet weak var productBrand: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
