//
//  HomeCategoryTableViewCell.swift
//  Abaya
//
//  Created by Kareem Mohammed on 2/9/18.
//  Copyright © 2018 Kareem Mohammed. All rights reserved.
//

import UIKit

class HomeCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!

    @IBOutlet weak var categoryImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(name: String, area: String, icon: UIImage) {
        categoryLabel.text = name
        areaLabel.text = area
        categoryImageView.image = icon
    }

}
