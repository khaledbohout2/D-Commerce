//
//  dashboardcell.swift
//  PEMS
//
//  Created by Unify Systems on 30/08/18.
//  Copyright © 2018 Unify Systems. All rights reserved.
//

import UIKit
import SDWebImage
class subcat2CollectionCell: UICollectionViewCell {
var strimgUrl = String()
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblBrand: UILabel!
    
    @IBOutlet var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    var helplineList:arrNewBlocks!
//    {
//        didSet
//        {
//
//            strimgUrl = .imagebaseURL + "banner/" + helplineList.logo
//            let fileUrl = NSURL(string: strimgUrl)
//
//            self.store_imageimage.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
//            })
//
//        }
//    }
}
