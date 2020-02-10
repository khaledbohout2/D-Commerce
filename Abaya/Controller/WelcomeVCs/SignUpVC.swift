//
//  SignUpVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 10/25/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import JGProgressHUD

class SignUpVC: UIViewController {
    
    var hud = JGProgressHUD(style: .extraLight)

    @IBOutlet weak var firstNameTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var surNameTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var emailAdressTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var mobileNumberTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var passWordTxtField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var confirmPasswordTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavButtons()
        
        let sesstioncheck = UserDefaults.standard.string(forKey: "session")
        if (sesstioncheck == "session")
        {
            let dic = UserDefaults.standard.object(forKey: "dictionaryKey") as? [AnyHashable: Any]
            
            
            loginAccessToken = dic?["token"] as! NSString
            //self.callTabBar()
            
        

        // Do any additional setup after loading the view.
    }
        
    }
    
    override func viewDidLayoutSubviews()
        
    {

        scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+200)
    }
    

    func setupNavButtons() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
       // title = LanguageManager.valueForKey(key: "")
        
        let backButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButtonItem
        navigationController?.navigationBar.setNeedsLayout()
      
    }
    
    @objc func backAction() {
        
        navigationController?.popViewController(animated: true)
    }
    @IBAction func SignUpButtonClicked(_ sender: Any) {
        if (firstNameTextField.text?.isEmpty)! {
            
            let alert = UIAlertController(title: "", message: .enter_username, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else if (surNameTextField.text?.isEmpty)! {
            
            let alert = UIAlertController(title: "", message: .enter_lastname, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else if (emailAdressTextField.text?.isEmpty)! {
            
            let alert = UIAlertController(title: "", message: .enter_email, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else if !isValidEmail(testStr: emailAdressTextField.text!) {
            // Added ! to the check to pass valid email.
            
            let alert = UIAlertController(title: "", message: .inValid_email, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else  if (!((emailAdressTextField.text?.isValidEmail())!)) {
            let alert = UIAlertController(title: "", message: .validEmail, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        else if (mobileNumberTextField.text?.isEmpty)! {
            
            let alert = UIAlertController(title: NSLocalizedString("Ok", comment: ""), message: .enter_mobile, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else if (passWordTxtField.text?.isEmpty)! {
            
            let alert = UIAlertController(title: "", message: .enter_password, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else if (passWordTxtField.text)!.count < 8 || (passWordTxtField.text)!.count > 12 {
            Alert.Show(title: NSLocalizedString("Error", comment: ""), mesage: NSLocalizedString("enter between 8 and 20 characters", comment: ""), viewcontroller: self)
        }
        else if (confirmPasswordTextField.text?.isEmpty)! {
            
            let alert = UIAlertController(title: "", message: .confirmPassword, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
            
        else{
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            let firstname:String = firstNameTextField.text!
            let lastname:String = surNameTextField.text!
            let email:String = emailAdressTextField.text!
            let mobile:String = mobileNumberTextField.text!
            let password:String = passWordTxtField.text!
            let c_password:String = confirmPasswordTextField.text!
            
            registerPram = [
                "first_name": firstname,
                "last_name": lastname,
                "email":email,
                "mobile":mobile,
                "password":password,
                "c_password":c_password,
                "device_token":"75bfd3a611aada805536279b32771c271e57fc2e0285abf6b5d22987ad663760",
            ]
            
            Requests.registrationApi { (success, jsonValue, error) in
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
                        
                        
                        let noInternetAlertController = UIAlertController.Style.alert.controller(
                            title: "",
                            message: "You are registered successfully!" ,
                            actions: [
                                "Ok".alertAction { _ in
                                    
                                   let CountryViewController = self.storyboard!.instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController

                                           self.navigationController?.pushViewController(CountryViewController, animated: true)
                                }
                            ])
                        self.present(noInternetAlertController, animated: true)
                        
                        
                        
                        
                        
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
    
    @IBAction func viewTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func loginButtontapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let SignInVC = storyboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        
        self.navigationController?.pushViewController(SignInVC, animated: true)
    }
    
}

