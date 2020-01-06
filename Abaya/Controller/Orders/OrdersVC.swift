//
//  OrdersVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/16/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import JGProgressHUD

class OrdersVC: UIViewController {
    
    var hud = JGProgressHUD(style: .extraLight)
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var headerView: UIView!
    


    
    var completedOrdersArr = NSArray()
    var activeOrdersArr = NSArray()
    
    var pageMenu : CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getCompletedOrders()
        self.getActiveOrders()
        
        

    }
    
    func getCompletedOrders() {
        
        DicParameters = [:]
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getUsersCompletedOrders(), completion: { [weak self] response in
            let errorCheck = response["success"] as! Bool
            
            if errorCheck
            {
                var dic = NSDictionary()
                dic = response as NSDictionary
                let data = dic["data"] as! NSArray
                self!.completedOrdersArr = data
   
                
                self?.hud.dismiss()
            }
            else
            {
                self?.hud.dismiss()
                  Alert.Show(title:NSLocalizedString("something wrong", comment: ""), mesage: NSLocalizedString("Please try again.", comment: ""), viewcontroller:self!)
                    
                }
                }, failure: { [weak self] failResponse in
                    self?.hud.dismiss()
                    Alert.Show(title: NSLocalizedString("network error", comment: ""), mesage:NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
        })
    }
    
    func getActiveOrders() {
        
        DicParameters = [:]
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getUsersActiveOrders(), completion: { [weak self] response in
            print("khaled \(response)")
            let errorCheck = response["success"] as! Bool
            
            if errorCheck
            {
                var dic = NSDictionary()
                dic = response as NSDictionary
                if let datadic = (dic["data"] as? NSDictionary) {
                let data = datadic .value(forKey: "data") as! NSArray
                print(data)
                self!.activeOrdersArr = data
                self!.addPageMenu()
                } else if (dic["data"] as? NSArray) != nil {
                    Alert.Show(title: NSLocalizedString("No Orders!", comment: ""), mesage: NSLocalizedString("you have not done any oders", comment: "") , viewcontroller: self!)
                }
                self?.hud.dismiss()
            }
            else
            {
                self?.hud.dismiss()
                Alert.Show(title:"something wrong", mesage:"Please try again.", viewcontroller:self!)
                
            }
            }, failure: { [weak self] failResponse in
                self?.hud.dismiss()
                Alert.Show(title:"network error", mesage:"Please try again.", viewcontroller:self!)
        })
    }
    
    

}

extension OrdersVC {
    
   
    func addPageMenu() {
        
        var controllerArray : [UIViewController] = []

              var active = OrdersList()
              active = OrdersList(nibName: "OrdersList", bundle: nil)

               controllerArray.append(active)
               active.title = NSLocalizedString("Active", comment: "") 
               active.ordersArr = activeOrdersArr
        
               var completed = OrdersList()
               completed = OrdersList(nibName: "OrdersList", bundle: nil)

                controllerArray.append(completed)
                completed.title = NSLocalizedString("Completed", comment: "")
                completed.ordersArr = completedOrdersArr
              
            

        
        let parameters = [CAPSPageMenuOptionScrollMenuBackgroundColor: UIColor.clear,
                          CAPSPageMenuOptionViewBackgroundColor: UIColor.white,
                          CAPSPageMenuOptionSelectionIndicatorColor: UIColor.black,
                          CAPSPageMenuOptionBottomMenuHairlineColor: UIColor.clear,
                          CAPSPageMenuOptionSelectedMenuItemLabelColor: UIColor.black,
                          CAPSPageMenuOptionUnselectedMenuItemLabelColor: UIColor.lightGray,
                          CAPSPageMenuOptionMenuItemSeparatorWidth:self.view.frame.width/2.2,
                          CAPSPageMenuOptionMenuItemFont: UIFont(name: "HelveticaNeue", size: 15.0)!, CAPSPageMenuOptionMenuHeight: 50.0, CAPSPageMenuOptionMenuItemWidth: self.view.frame.width/4.5, CAPSPageMenuOptionCenterMenuItems: true] as [String : Any]
        
        // Initialize scroll menu
       
            pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: self.view.frame.origin.x, y: headerView.frame.origin.y+headerView.frame.size.height+5, width: self.view.frame.width, height: self.view.frame.height), options: parameters)
       
        pageMenu?.view.backgroundColor = UIColor.clear
        self.addChild(pageMenu!)
        contentView.addSubview(pageMenu!.view)
        //pageMenu!.didMove(toParentViewController: self)
//        pageControl.isHidden = false
//        lblBrowseShops.isHidden = false
    }
}

