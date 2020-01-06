//
//  SplashViewController.swift
//  Abaya
//
//  Created by Khaled Bohout on 10/25/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.moveToCountries()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
        func moveToCountries() {
            
            
                    let sesstioncheck = UserDefaults.standard.string(forKey: "session")
                    if (sesstioncheck == "session")
                    {
                    
                        let dic = UserDefaults.standard.object(forKey: "dictionaryKey") as? [AnyHashable: Any]
                        loginAccessToken = dic?["token"] as! NSString


                        let homeVC = HomeVC(nibName: "productDetail", bundle: nil)
                        self.navigationController?.pushViewController(homeVC, animated: true)
            //            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //            let vc = storyboard.instantiateViewController(withIdentifier: "OrderConfirmVC")
            //            let aObjNavi = UINavigationController(rootViewController: vc);                        self.window?.addSubview(aObjNavi.view)
            //            self.window?.rootViewController = aObjNavi
                        
                    }else{
                        
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let SignInVC = storyboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                
                self.navigationController?.pushViewController(SignInVC, animated: true)
                        
                    }
            
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//            let SignInVC = storyboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
//
//            self.navigationController?.pushViewController(SignInVC, animated: true)
            

        }
    



}
