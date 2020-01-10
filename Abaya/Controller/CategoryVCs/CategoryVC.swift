//
//  CategoryVC.swift
//  Abaya
//
//  Created by khaled Bohout on 11/7/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import JGProgressHUD
import SDWebImage


class CategoryVC: UIViewController {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    @IBOutlet weak var browseProductslbl: UILabel!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    var dicDetail = NSDictionary()
    var arrCategory = NSArray()
    var pageMenu : CAPSPageMenu?
    var hud = JGProgressHUD(style: .extraLight)
  //  let lastcat = arrCategory[IndexPath.row]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProducts()
        // Do any additional setup after loading the view.
    }

    
    func loadProducts() {
        
        hud.textLabel.text = NSLocalizedString("loading", comment: "")
        
        hud.show(in: self.view)
        
        let arrCat1 = dicDetail .value(forKey: "children") as! NSArray

        arrCategory = arrCat1
        
        self.title = (dicDetail.value(forKey: NSLocalizedString("category_name", comment: "")) as! String)
        
        let imgStrUrl = .imagebaseURL + "category/" + (dicDetail.value(forKey: "category_image") as! String)
        
        self.addPageMenu(count: arrCategory.count)
        
        let fileUrl = URL(string: imgStrUrl)
        
        bannerImageView.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: "store_cover_two"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        
      //  bannerImageView.image = UIImage(url: fileUrl)
        
        hud.dismiss()
    }

}

extension CategoryVC {
    
    func addPageMenu(count: Int) {
        var controllerArray : [UIViewController] = []
       // print(CategoryList)
       
        var dic = NSDictionary()
        
        for  i in arrCategory {
            
             var controller = CategoryPageVC()
             controller  = CategoryPageVC(nibName: "CategoryPageVC", bundle: nil)
            
               controllerArray.append(controller)
            
               dic = i as! NSDictionary
            
               controller.title = dic.value(forKey: NSLocalizedString("category_name", comment: "")) as? String
               controller.lastCat = dic.value(forKey: "children") as! NSArray
            
        }
        
        let parameters = [CAPSPageMenuOptionScrollMenuBackgroundColor: UIColor.clear,
                          CAPSPageMenuOptionViewBackgroundColor: UIColor.white,
                          CAPSPageMenuOptionSelectionIndicatorColor: UIColor.black,
                          CAPSPageMenuOptionBottomMenuHairlineColor: UIColor.clear,
                          CAPSPageMenuOptionSelectedMenuItemLabelColor: UIColor.black,
                          CAPSPageMenuOptionUnselectedMenuItemLabelColor: UIColor.lightGray,
                          CAPSPageMenuOptionMenuItemSeparatorWidth:self.view.frame.width/2.2,
                          CAPSPageMenuOptionMenuItemFont: UIFont(name: "HelveticaNeue", size: 15.0)!, CAPSPageMenuOptionMenuHeight: 50.0, CAPSPageMenuOptionMenuItemWidth: self.view.frame.width/4.5, CAPSPageMenuOptionCenterMenuItems: true] as [String : Any]
        
        // Initialize scroll menu
       
            pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: self.view.frame.origin.x, y: browseProductslbl.frame.origin.y+browseProductslbl.frame.size.height+5, width: self.view.frame.width, height: self.view.frame.height - bannerImageView.frame.size.height), options: parameters)
       
        pageMenu?.view.backgroundColor = UIColor.clear
        self.addChild(pageMenu!)
        scroll.addSubview(pageMenu!.view)
        

    }
}
