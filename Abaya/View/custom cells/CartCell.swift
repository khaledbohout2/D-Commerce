//
//  CartCell.swift
//  Abaya
//
//  Created by Chandar on 14/05/19.
//  Copyright © 2019 Kareem Mohammed. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {
    
    
    @IBOutlet weak var lblProductName: UILabel!
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblQty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
