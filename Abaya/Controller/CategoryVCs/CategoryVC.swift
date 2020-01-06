//
//  CategoryVC.swift
//  Abaya
//
//  Created by khaled Bohout on 11/7/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import JGProgressHUD


class CategoryVC: UIViewController {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    @IBOutlet weak var browseProductslbl: UILabel!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    var imgUrl = String()
    var pageMenu : CAPSPageMenu?
    var hud = JGProgressHUD(style: .extraLight)
  //  let lastcat = arrCategory[IndexPath.row]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addPageMenu(count: arrCategory.count)
        
        hud.textLabel.text = NSLocalizedString("loading", comment: "") 
        hud.show(in: self.view)
        
        let fileUrl = URL(string: imgUrl)
        bannerImageView.image = UIImage(url: fileUrl)
        
        hud.dismiss()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
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
            
           // controller.arrSubCategoryList_2 = dic.value(forKey: "children") as! NSArray
            
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
