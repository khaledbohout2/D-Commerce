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

    var completedOrdersArr = Array<Any>()
    var activeOrdersArr = Array<Any>()
    
    var pageMenu : CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBySwipe()
        
        setupNavButtons()
        
        self.getCompletedOrders()
        self.getActiveOrders()

    }
    
    func backBySwipe() {
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        self.view.addGestureRecognizer(gesture)
    }
    

    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {

        self.navigationController?.popViewController(animated: true)
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
                let data = dic["data"] as! Array<Any>
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
                    let data = datadic .value(forKey: "data") as! Array<Any>
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

    }
}

extension OrdersVC {
    
    func setupNavButtons() {
        
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.title = NSLocalizedString("Addresses", comment: "")
        
        
        let backButton = UIBarButtonItem(image: UIImage(named: NSLocalizedString("back_arrow", comment: "")), style: .plain, target: self, action: #selector(backAction))
        
        navigationItem.leftBarButtonItem = backButton
        
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    @objc func backAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}

