//
//  dashboardcell.swift
//  PEMS
//
//  Created by Unify Systems on 30/08/18.
//  Copyright © 2018 Unify Systems. All rights reserved.
//

import UIKit
import SDWebImage
class subCatCell: UICollectionViewCell {

    @IBOutlet var store_name: UILabel!
    @IBOutlet var store_coutry: UILabel!
    @IBOutlet var store_imageimage: UIImageView!
    var strimgUrl = String()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
