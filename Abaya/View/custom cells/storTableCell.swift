//
//  storTableCell.swift
//  Abaya
//
//  Created by Chandar on 29/10/18.
//  Copyright © 2018 Kareem Mohammed. All rights reserved.
//

import UIKit
import SDWebImage

class storTableCell: UITableViewCell {
    
    @IBOutlet var store_name: UILabel!
    @IBOutlet var store_coutry: UILabel!
    @IBOutlet var store_imageimage: UIImageView!
    var strimgUrl = String()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var helplineList:HelplineList!
    {
        didSet
        {
            self.store_name.text = helplineList.store
            self.store_coutry.text = helplineList.country
            
            strimgUrl = .imagebaseURL + "banner/" + helplineList.logo
            let fileUrl = NSURL(string: strimgUrl)
            
            self.store_imageimage.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
            })
            
        }
    }
}
