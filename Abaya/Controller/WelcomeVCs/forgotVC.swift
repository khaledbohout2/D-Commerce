//
//  forgotVc.swift
//  Abaya
//
//  Created by Khaled Bohout on 10/25/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class forgotVC: UIViewController {


    @IBOutlet weak var mailTextField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    



    @IBAction func restPassButtonPressed(_ sender: Any) {
        
        guard mailTextField.text != "" else {
            return
        }
        guard isValidEmail(testStr: mailTextField.text!) else {
            
            let alert = UIAlertController(title: "", message: .inValid_email, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        forfotPassword()
    }

    @IBAction func SignUpButtonPressed(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let SignUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        
        self.navigationController?.pushViewController(SignUpVC, animated: true)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func forfotPassword() {
        
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)
        
        let par = ["email" : mailTextField.text] as! [String : String]
        
        ApiBaseClass.apiCallingMethode(url: BaseUrl.forgotPassword(), parameter: par, completion: { (response) in
            let success = response["success"] as! Bool
            if success {
                
                hud.dismiss()
                
                let data = response["data"] as! [String : Any]
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let resetVC = storyboard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
                resetVC.data = data
                self.navigationController?.pushViewController(resetVC, animated: true)
                
            } else {
                hud.dismiss()
                Alert.Show(title: NSLocalizedString("Invalid Email", comment: ""), mesage: NSLocalizedString("can not found this email", comment: ""), viewcontroller: self)
            }
        }) { (error) in
            hud.dismiss()
            Alert.Show(title: NSLocalizedString("Not Connected", comment: ""), mesage: NSLocalizedString("please check your internet connection", comment: ""), viewcontroller: self)
        }
    }
    
    func setupNavButtons() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
   //     title = LanguageManager.valueForKey(key: "")
        
       let backButton = UIBarButtonItem(image: UIImage(named: NSLocalizedString("back_arrow", comment: "")), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.setNeedsLayout()
        
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
}
