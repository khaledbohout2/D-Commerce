//
//  ResetPasswordVC.swift
//  Blocks
//
//  Created by Khaled Bohout on 2/21/20.
//  Copyright © 2020 Khaled Bohout. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ResetPasswordVC: UIViewController {
    
    @IBOutlet weak var mailTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var newPassTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var confirmPassTF: SkyFloatingLabelTextField!
    
    @IBOutlet weak var forgotPassLabel: UILabel!
    
    @IBOutlet weak var WAHTHLabel: UILabel!
    
    @IBOutlet weak var resetCodeLabel: UILabel!
    
    @IBOutlet weak var ResetPassBtn: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    var data = [String : Any] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeLocalization()

        // Do any additional setup after loading the view.
    }
    
    func makeLocalization() {
        
        mailTF.placeholder = NSLocalizedString("Reset Password Code", comment: "")
        newPassTF.placeholder = NSLocalizedString("New Password", comment: "")
        confirmPassTF.placeholder = NSLocalizedString("Confirm New Password", comment: "")
        signUpLabel.text = NSLocalizedString("New to Blocks? Sign up", comment: "")
        forgotPassLabel.text = NSLocalizedString("Forgot password?", comment: "")
        WAHTHLabel.text = NSLocalizedString("we're here to help!", comment: "")
        resetCodeLabel.text = NSLocalizedString("Reset password code sent to your E-mail", comment: "")
        ResetPassBtn.titleLabel?.text = NSLocalizedString("Reset Password", comment: "")
        titleLabel.text = NSLocalizedString("PASSWORD RESET", comment: "")
    }
    
    func resetPassword() {
        
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)
        
        let user = data["user"] as! [String : Any]
        
        let email = user["email"] as! String
        
        let token = mailTF.text
        
        let newPass = newPassTF.text
        
        let cnewPass = confirmPassTF.text
        
        let par = ["email" : email, "token" : token!, "password" :newPass!, "c_password" : cnewPass] as! [String : String]
        
        print(par)
        
        ApiBaseClass.apiCallingMethode(url: BaseUrl.resetPassword(), parameter: par, completion: { (response) in
            let success = response["success"] as! Bool
            print(response)
            if success {
                hud.dismiss()
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let SignInVC = storyboard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                
                self.navigationController?.pushViewController(SignInVC, animated: true)
                
            } else {
                hud.dismiss()
                Alert.Show(title: NSLocalizedString("wrong code", comment: ""), mesage: NSLocalizedString("", comment: ""), viewcontroller: self)
            }
        }) { (error) in
            hud.dismiss()
            Alert.Show(title: NSLocalizedString("Not Connected", comment: ""), mesage: NSLocalizedString("please check your internet connection", comment: ""), viewcontroller: self)
        }
    }
    
    @IBAction func resetPasswordBtnTapped(_ sender: Any) {
        
        guard mailTF.text != "" else {
            
            let alert = UIAlertController(title: "", message: .enter_email, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        guard newPassTF.text != "" else {
            
            let alert = UIAlertController(title: "", message: .enter_password, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
           
            return
        }
        guard confirmPassTF.text != "" else {
            
            let alert = UIAlertController(title: "", message: .confirmPassword, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        guard newPassTF.text == confirmPassTF.text else {
            
            Alert.Show(title: NSLocalizedString("passwords do not match", comment: ""), mesage: "", viewcontroller: self)
            
            return
        }
        guard !(newPassTF.text!.count < 8 || newPassTF.text!.count > 12) else {
            
            Alert.Show(title: NSLocalizedString("Error", comment: ""), mesage: NSLocalizedString("enter between 8 and 20 characters", comment: ""), viewcontroller: self)
            
            return
        }
        
        resetPassword()
    }
    

}
