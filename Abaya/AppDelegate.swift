//
//  AppDelegate.swift
//  Abaya
//
//  Created by Khaled Bohout on 10/25/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import MOLH
import IQKeyboardManagerSwift


var registerPram = NSDictionary()
var strDeviceToken = String()
var changpasswordParam = HTTPHeaders()
var loginAccessToken = NSString()
var Authorization = HTTPHeaders()
var DicParameters = [String : String]()
//var strShopProductId = NSString()
var strProductId = String()
var strDeleteId = String()
var dicLoginUserData = NSDictionary()
var CategoryList = NSArray()
var arrCategory = NSArray()
var strNavTitle = String()
var dicNewsDetail = NSDictionary()
var dicUserProfile = NSDictionary()
var strDeviceid = String()
//var strShopProductId = NSString()
var hud = JGProgressHUD(style: .extraLight)
var strAddToCartProductId = NSString()
var strQty = NSString()
var strSkuId = NSString()
var isCountry = Bool()
var itemTODelete = String()
var addressDic = NSDictionary()
var textTosearch = String()
var productToFilter = String()
var orderByNew = String()
var orderToTrack = NSString()
var minPrice = String()
var maxPrice = String()
var priductId = String()
var categpryID = String()
//var addressID = String()


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MOLHResetable {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//                let sesstioncheck = UserDefaults.standard.string(forKey: "session")
//                if (sesstioncheck == "session")
//                {
//
//                    var dic = UserDefaults.standard.object(forKey: "dictionaryKey") as? [AnyHashable: Any]
//                    loginAccessToken = dic?["token"] as! NSString
//
//
//                    let vc = productDetail(nibName: "productDetail", bundle: nil)
//                      let aObjNavi = UINavigationController(rootViewController: vc);                 self.window?.addSubview(aObjNavi.view)
//                         self.window?.rootViewController = aObjNavi
//
//
//        //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        //            let vc = storyboard.instantiateViewController(withIdentifier: "OrderConfirmVC")
//        //            let aObjNavi = UINavigationController(rootViewController: vc);                        self.window?.addSubview(aObjNavi.view)
//        //            self.window?.rootViewController = aObjNavi
//
//                }
//                else{
//
//                }
        //MOLHLanguage.setDefaultLanguage("ar")
        IQKeyboardManager.shared.enable = true
        MOLH.shared.activate(true)
       // MOLH.shared.specialKeyWords = ["Cancel","Done"]
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
//    func setupLanguage() {
//        let lang = LanguageManager.getLanguage()
//        L102Localizer.switchTheLanguage(lan: lang, fromrestPage: true)
//        L102Localizer.DoTheMagic()
//    }

    
    func reset() {
        
        if #available(iOS 13.0, *) {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate!.swichRoot()
        } else {
        // Fallback on earlier versions
        MOLH.reset()
        }
    }
    
    @available (iOS 13.0, *)
    func swichRoot() {
        
        animateView()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let navigation = storyboard.instantiateViewController(withIdentifier: "navigation")
        
      //  let homeVC = HomeVC(nibName: "productDetail", bundle: nil)
        
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sd.window?.rootViewController = navigation
        }
    }

      @available(iOS 13.0, *)
       func animateView() {
           var transition = UIView.AnimationOptions.transitionFlipFromRight
           if !MOLHLanguage.isRTLLanguage() {
               transition = .transitionFlipFromLeft
           }
          animateView(transition: transition)
       }
       
       @available(iOS 13.0, *)
       func animateView(transition: UIView.AnimationOptions) {
           if let delegate = UIApplication.shared.connectedScenes.first?.delegate {
               UIView.transition(with: (((delegate as? SceneDelegate)!.window)!), duration: 0.5, options: transition, animations: {}) { (f) in
               }
           }
       }
    
        func goToApp() {

//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//            let navigation = storyboard.instantiateViewController(withIdentifier: "navigation")
            
            let homeVC = HomeVC(nibName: "productDetail", bundle: nil)
            
            let scene = UIApplication.shared.connectedScenes.first
            if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
                sd.window?.rootViewController = homeVC
            }
        }
    


}

