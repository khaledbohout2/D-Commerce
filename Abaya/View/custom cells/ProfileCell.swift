//
//  ProfileCell.swift
//  Abaya
//
//  Created by Chandar on 17/03/19.
//  Copyright © 2019 Kareem Mohammed. All rights reserved.
//

import UIKit

class ProfileCell: UITableViewCell {
    
    @IBOutlet weak var imgList: UIImageView!
    
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblList: UILabel!
    
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
