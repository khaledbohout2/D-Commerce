//
//  CardsCell.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/19/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit

class CardsCell: UITableViewCell {

    @IBOutlet weak var orderNumberLbl: UILabel!
    @IBOutlet weak var cardNumberLbl: UILabel!
    @IBOutlet weak var expiredOnLbl: UILabel!
    @IBOutlet weak var btnCheckMark: UIButton!
    @IBOutlet weak var defaultLbl: UILabel!
    @IBOutlet weak var cardTypeImageView: UIImageView!
    
    @IBOutlet weak var btnEdit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
