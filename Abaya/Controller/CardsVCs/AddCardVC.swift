//
//  AddCardVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/20/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AddCardVC: UIViewController {

    @IBOutlet weak var cardNumberTxtField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var cardHolderNameTxtField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var expiryDateTxtField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var expiryYearTxtField: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavButtons() 
    }
    
    func AddCardApiHit()
    {
        
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        let cardNumber:String = cardNumberTxtField.text!
        let cardHolderName:String = cardHolderNameTxtField.text!
        let expiryDate:String = expiryDateTxtField.text!
        let expiryYear:String = expiryYearTxtField.text!

        
        DicParameters = ["cardno":cardNumber, "name_on_credit_card":cardHolderName, "expiry_date":expiryDate, "expiry_year":expiryYear]
        
        ApiBaseClass.apiCallingMethode(url:ApiBaseClass.addNewCard(), parameter:DicParameters , completion: { [weak self] response in
            let errorCheck = response["success"] as! Bool
            _ = response as NSDictionary
            if errorCheck
            {
                hud.dismiss()

                let alrtcotr  = UIAlertController.init(title: "", message: "New address add successfully", preferredStyle: .alert)
                
                let nextAction: UIAlertAction = UIAlertAction(title: "Ok", style: .default) { action -> Void in
                    
                    self?.navigationController?.popViewController(animated: true)
                }
                alrtcotr.addAction(nextAction)
                self?.present(alrtcotr, animated: true, completion: nil)
                
            }
            else
            {
                hud.dismiss()
                Alert.Show(title:"something wrong", mesage:"Please try again.", viewcontroller:self!)
                
            }
            }, failure: { [weak self] failResponse in
                hud.dismiss()
                Alert.Show(title:"network error", mesage:"Please try again.", viewcontroller:self!)
        })
    }

    

    

}

// MARK:- Navigation
extension AddCardVC  {
    
    func setupNavButtons() {
        
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       // self.navigationController?.navigationBar.shadowImage = UIColor.redColor.as1ptImage()
        self.title = "Add Address"
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton
        let btnSave = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        navigationItem.rightBarButtonItem = btnSave
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    @objc func backAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveAction()
    {
        if (cardNumberTxtField.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_firstname , viewcontroller:self)
        }
        else if (cardHolderNameTxtField.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_lastname , viewcontroller:self)
        }
        else if (expiryDateTxtField.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.validmobile , viewcontroller:self)
        }
        else if (expiryYearTxtField.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.address1 , viewcontroller:self)
        }

        else{
           self.AddCardApiHit()
        }
        
       
    }
}

