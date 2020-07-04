//
//  ProductColorCell.swift
//  Blocks
//
//  Created by Khaled Bohout on 7/4/20.
//  Copyright © 2020 Khaled Bohout. All rights reserved.
//

import UIKit

class ProductColorCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        colorView.layer.shadowColor = UIColor(hexString: "#808080", alpha: 0.2).cgColor
        colorView.layer.shadowOpacity = 1
        colorView.layer.shadowOffset = CGSize(width: 0, height: 2)
        colorView.layer.shadowRadius = 4
    }


}
