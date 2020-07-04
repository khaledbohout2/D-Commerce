//
//  ProductListCell.swift
//  NARI
//
//  Created by Rajendra Kumar on 16/07/18.
//  Copyright © 2018 technoBrix. All rights reserved.
//

import UIKit

class ProductListCell: UICollectionViewCell {
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var image_view: UIImageView!
    
    @IBOutlet weak var lab:UILabel!

    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lbldetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
