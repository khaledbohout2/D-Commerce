//
//  AddAddressVC.swift
//  Abaya
//
//  Created by Rajendra Kumar on 16/03/19.
//  Copyright © 2019 Kareem Mohammed. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire

class AddAddressVC: UIViewController,UIScrollViewDelegate,SetState {

    
    @IBOutlet var tftFirstName: UITextField!
    @IBOutlet var tftLastName: UITextField!
    @IBOutlet var tftPhone: UITextField!
    @IBOutlet var tftAddress1: UITextField!
    @IBOutlet var tftAddress2: UITextField!
    @IBOutlet var tftPostcode: UITextField!
    @IBOutlet var tftCountry: UITextField!
    @IBOutlet var tftState: UITextField!
    @IBOutlet var tftcity: UITextField!
    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!

    var strFirstName = NSString()
    var strLastName = NSString()
    var strEmail = NSString()
    var strMobile = NSString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBySwipe()
        
        tftCountry.isUserInteractionEnabled = false
        tftState.isUserInteractionEnabled = false
        strCountryID = ""
        strStateID = ""
       
        setupNavButtons()
        
//        scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+600)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool)
        
    {
   

        
    }
    
    func backBySwipe() {
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        self.view.addGestureRecognizer(gesture)
    }
    

    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {

        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func btnCountryClicked(_ sender: Any) {
        
        isCountry = true
        
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "CountryStateVC") as! CountryStateVC
        
        obj.delegate = self
        
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    @IBAction func btnStateClicked(_ sender: Any) {
        
        isCountry = false
        
        if strCountryID .isEqual(to: "") {
            
            Alert.Show(title:"", mesage: NSLocalizedString("Please select country.", comment: "") , viewcontroller:self)
            
        }
            
        else{
        
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "CountryStateVC") as! CountryStateVC
            obj.delegate = self
        self.navigationController?.pushViewController(obj, animated: true)
            
        }
    }
    
    
    @IBAction func viewTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    func AddAddressApiHit()
    {
        
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)
        let strFirstName:String = tftFirstName.text!
        let strLastName:String = tftLastName.text!
        let strPhone:String = tftPhone.text!
        let strAdd1:String = tftAddress1.text!
        let strAdd2:String = tftAddress2.text!
        let strPincode:String = tftPostcode.text!
        let strCity:String = tftcity.text!
        
        DicParameters = ["first_name":strFirstName, "last_name":strLastName, "email":strEmail, "mobile":strPhone,"address1"
            :strAdd1,"address2":strAdd2,"postcode":strPincode,"country_id":strCountryID,"state_id":strStateID,"city":strCity] as [String : Any] as! [String : String]
        
        ApiBaseClass.apiCallingMethode(url:ApiBaseClass.addNewAddress(), parameter:DicParameters , completion: { [weak self] response in
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
                  Alert.Show(title:NSLocalizedString("something wrong", comment: ""), mesage: NSLocalizedString("Please try again.", comment: ""), viewcontroller:self!)
                    
                }
                }, failure: { [weak self] failResponse in
                    hud.dismiss()
                    Alert.Show(title: NSLocalizedString("network error", comment: ""), mesage:NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)

        })
    }
    
        override func viewDidLayoutSubviews()
        {
            
        scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+100)

    //        self.view.frame = (frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height+600))
            
        }
    
    func didSetState() {
        
        if !strCountryID .isEqual(to: "") {
            tftCountry.text = strCountryName as String
        }
        
        if !strStateID .isEqual(to: "") {
            tftState.text = strStateName as String
        }
    }
    
   
}
// MARK:- Navigation
extension AddAddressVC {
    
    func setupNavButtons() {
        
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       // self.navigationController?.navigationBar.shadowImage = UIColor.redColor.as1ptImage()
        self.title = NSLocalizedString("Add Address", comment: "")
        
        let backButton = UIBarButtonItem(image: UIImage(named: NSLocalizedString("back_arrow", comment: "")), style: .plain, target: self, action: #selector(backAction))
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
        if (tftFirstName.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_firstname , viewcontroller:self)
        }
        else if (tftLastName.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_lastname , viewcontroller:self)
        }else if (tftPhone.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.emptyMomileNumber , viewcontroller:self)
        } else if tftPhone.text!.count > 12 || tftPhone.text!.count < 10  {
            Alert.Show(title:"", mesage:.validmobile , viewcontroller:self)
        }else if (tftAddress1.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.address1 , viewcontroller:self)
        }
        else if (tftAddress2.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.address2 , viewcontroller:self)
        }
        else if (tftPostcode.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_postelcode , viewcontroller:self)
        }
        else if (tftCountry.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_country , viewcontroller:self)
        }
        else if (tftState.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_state , viewcontroller:self)
        }
        else if (tftcity.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_city , viewcontroller:self)
        }
        else{
           self.AddAddressApiHit()
        }
        
       
    }
}

