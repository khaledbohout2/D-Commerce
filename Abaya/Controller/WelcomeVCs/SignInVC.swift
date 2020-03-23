//
//  ViewController.swift
//  Abaya
//
//  Created by Khaled Bohout on 10/25/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import JGProgressHUD

class SignInVC: UIViewController {
    
    var hud = JGProgressHUD(style: .extraLight)

    @IBOutlet weak var continueAsGuestButton: UIButton!
    
    @IBOutlet weak var orButton: UILabel!
    @IBOutlet weak var emailTxtField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTxtField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isAppAlreadyLaunchedOnce() {
            
            continueAsGuestButton.isHidden = true
            continueAsGuestButton.isUserInteractionEnabled = false
            orButton.isHidden = true
            orButton.isUserInteractionEnabled = false
            
        }
        // Do any additional setup after loading the view.
        
        let sesstioncheck = UserDefaults.standard.string(forKey: "session")
        
        if (sesstioncheck == "session")
            
        {
            if let dic = UserDefaults.standard.object(forKey: "dictionaryKey") as? [AnyHashable: Any]
            {
            
            loginAccessToken = dic["token"] as! NSString
           
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }


    @IBAction func loginButton(_ sender: Any) {
        

        
           if (emailTxtField.text?.isEmpty)! {
               
            let alert = UIAlertController(title: "", message:"Enter Username/Email Address", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
               self.present(alert, animated: true, completion: nil)
               
           }
           else if (passwordTxtField.text?.isEmpty)! {
               
            let alert = UIAlertController(title: "", message: .enter_password, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
               self.present(alert, animated: true, completion: nil)
               
           }
           else{
           hud.textLabel.text = NSLocalizedString("Loading", comment: "") 
           hud.show(in: self.view)
           let username:String = emailTxtField.text!
           
           let pass:String = passwordTxtField.text!
        
           registerPram = [
               "email": username,
               "password": pass,
              ]
           
           Requests.LoginApi { (success, jsonValue, error) in
               if success{
               
                   self.hud.dismiss()
                   let responseJSON = jsonValue as! [String:AnyObject]
                     
                   var dic = NSDictionary()
                   dic = responseJSON as NSDictionary
                 
                   let boolValue: Bool = dic.value(forKey: "success") as!Bool
                   if boolValue
                   {
                       dicLoginUserData = (dic["data"] as! NSDictionary)
                       
                       loginAccessToken = dicLoginUserData["token"] as! NSString
                       
                       UserDefaults.standard.set(dicLoginUserData, forKey: "dictionaryKey")
                     //  print("This is Login Access Token :- ",loginAccessToken)
                       UserDefaults.standard.set("session", forKey: "session")
                       UserDefaults.standard.synchronize()
                     
                    
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               let homeVC = storyboard.instantiateViewController(withIdentifier: "NewHomeVC") as! HomeVC
               self.navigationController?.pushViewController(homeVC, animated: true)
                   
               }
               
               else
                   {
                       self.hud.dismiss()
                    let noInternetAlertController = UIAlertController.Style.alert.controller(
                           title: "",
                           message: dic.value(forKey: "message") as! String,
                           actions: [
                               "Ok".alertAction(),
                               ])
                       
                       self.present(noInternetAlertController, animated: true)
                   }
           }
               
               else{
                   self.hud.dismiss()
                let noInternetAlertController = UIAlertController.Style.alert.controller(
                       title: "",
                       message: (error?.localizedDescription)!,
                       actions: [
                           "Ok".alertAction(),
                           ])
                   
                   self.present(noInternetAlertController, animated: true)
               }
               }
           
           }

        
    }
    
    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched")
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    @IBAction func forgotOassButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let forgotVC = storyboard.instantiateViewController(withIdentifier: "forgotVC") as! forgotVC
        
        self.navigationController?.pushViewController(forgotVC, animated: true)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let SignUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        
        self.navigationController?.pushViewController(SignUpVC, animated: true)
    }
    
    @IBAction func loginWithFacebookButton(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeVC = storyboard.instantiateViewController(withIdentifier: "NewHomeVC") as! HomeVC
        self.navigationController?.pushViewController(homeVC, animated: true)
//        let homeVC = NewHomeViewController(nibName: "NewHomeViewController", bundle: nil)
//        self.navigationController?.pushViewController(homeVC, animated: true)
    }

}


