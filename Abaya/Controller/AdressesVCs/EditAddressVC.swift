
//
//  EditAddressVC.swift
//  Abaya
//
//  Created by Rajndra Kumar on 12/04/19.
//  Copyright © 2019 Kareem Mohammed. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class EditAddressVC: UIViewController ,UIScrollViewDelegate {

    
    
    
    @IBOutlet weak var tftAddress1: SkyFloatingLabelTextField!
    
    @IBOutlet weak var tftCity: SkyFloatingLabelTextField!
    
    @IBOutlet weak var tftFirstName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var tftCountry: SkyFloatingLabelTextField!
    
    @IBOutlet weak var tftPhone: SkyFloatingLabelTextField!
    
    @IBOutlet weak var tftLastName: SkyFloatingLabelTextField!
    
    @IBOutlet weak var tftState: SkyFloatingLabelTextField!
    
    @IBOutlet weak var tftAddress2: SkyFloatingLabelTextField!
    
    @IBOutlet weak var tftPostCode: SkyFloatingLabelTextField!
    
    @IBOutlet weak var scroll: UIScrollView!
    
    var strFirstName = NSString()
    var strLastName = NSString()
    var strEmail = NSString()
    var strMobile = NSString()
    var arrCountry = NSArray()
    var arrStates = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(addressDic)
        
        GetCountryList()
        
        
        tftCountry.isUserInteractionEnabled = false
        tftState.isUserInteractionEnabled = false
        strCountryID = ""
        strStateID = ""

        setupNavButtons()
        
    }
    
     override func viewWillAppear(_ animated: Bool)
     {
    

         if !strCountryID .isEqual(to: "") {
             tftCountry.text = strCountryName as String
         }
         
         if !strStateID .isEqual(to: "") {
             tftState.text = strStateName as String
         }
     }
    
    func getTXtData() {
        
        tftAddress1.text = addressDic .value(forKey: "address1") as? String
        tftCity.text = addressDic .value(forKey: "city") as? String
        tftFirstName.text = addressDic .value(forKey: "first_name") as? String
        tftPhone.text = addressDic .value(forKey: "mobile") as? String
        tftLastName.text = addressDic .value(forKey: "last_name") as? String
        tftAddress2.text = addressDic .value(forKey: "address2") as? String
        tftPostCode.text = addressDic .value(forKey: "postcode") as? String
        tftCountry.text = strCountryName as String
        tftState.text = strStateName as String
 
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        
        self.view.endEditing(true)
    }
    
    
    @IBAction func btnCountryClicked(_ sender: Any) {
        
        isCountry = true
        
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "CountryStateVC") as! CountryStateVC
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    @IBAction func btnStateClicked(_ sender: Any) {
        isCountry = false
        if strCountryID .isEqual(to: "") {
            
            Alert.Show(title:"", mesage: NSLocalizedString("Please select country.", comment: "") , viewcontroller:self)
            
        }
        else{
        
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "CountryStateVC") as! CountryStateVC
        self.navigationController?.pushViewController(obj, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews(){
            
                
            scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+100)

        //        self.view.frame = (frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height+600))
                
            }

}
// MARK:- Navigation
extension EditAddressVC {
    
    func setupNavButtons() {

        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.title = NSLocalizedString("Edit Address", comment: "")
        
        
        let backButton = UIBarButtonItem(image: UIImage(named: NSLocalizedString("back_arrow", comment: "")), style: .plain, target: self, action: #selector(backAction))
        
        navigationItem.leftBarButtonItem = backButton
        
        let btnSave = UIBarButtonItem(image: #imageLiteral(resourceName: "tickMark"), style: .plain, target: self, action:#selector(saveAction))
        
        navigationItem.rightBarButtonItems = [btnSave]
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    @objc func backAction()
        
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveAction()
        
    {
        
         strDeleteId = String(format: "%@",addressDic.value(forKey: "id") as! CVarArg) as String
        // print(strDeleteId)
         DeleteUserAddress()

        if (tftFirstName.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_firstname , viewcontroller:self)
        }
        else if (tftLastName.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_lastname , viewcontroller:self)
        }
        else if (tftPhone.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.emptyMomileNumber , viewcontroller:self)
        } else if tftPhone.text!.count > 12 || tftPhone.text!.count < 10  {
            Alert.Show(title:"", mesage:.validmobile , viewcontroller:self)
        } else if (tftAddress1.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.address1 , viewcontroller:self)
        }
        else if (tftAddress2.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.address2 , viewcontroller:self)
        }
        else if (tftPostCode.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_postelcode , viewcontroller:self)
        }
        else if (tftCountry.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_country , viewcontroller:self)
        }
        else if (tftState.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_state , viewcontroller:self)
        }
        else if (tftCity.text?.isEmpty )! {
            Alert.Show(title:"", mesage:.enter_city , viewcontroller:self)
        }
        else{
           self.AddAddressApiHit()
        }
    }
    
    func DeleteUserAddress()
    {
        //DicParameters = ["id":strDeleteId] as [String : String]
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)
       // print(strDeleteId)
       // let url = "http://theblocksapp.com/api/deleteUserAddress/\(strDeleteId)"
      //  print(url)
        ApiBaseClass.apiCallingWithDeleteMethode(url:ApiBaseClass.deleteUserAddresses(), completion: { [weak self] response in
            
            hud.dismiss()
            //self!.GetUserAddress()
            //self?.tblAddresses.reloadData()
            
            

            }, failure: { [weak self] failResponse in
                hud.dismiss()
                Alert.Show(title:"", mesage:.no_internet, viewcontroller:self!)
        })
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
        let strPincode:String = tftPostCode.text!
        let strCity:String = tftCity.text!
        
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

        func GetCountryList()
        {
            
            
            DicParameters = [:]
            hud.textLabel.text = "Loading"
            hud.show(in: self.view)
            ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getCountryList(), completion: { [weak self] response in
                print(response)
                let errorCheck = response["success"] as! Bool
                
                if errorCheck
                {
                    //                    self?.obj.responseFromJson(dic:response)
                    
                    var dic = NSDictionary()
                    dic = response as NSDictionary
                    self?.arrCountry = dic["data"] as! NSArray
                    
                    let countryId = addressDic .value(forKey: "country_id") as? Int
                    
                    for country in self!.arrCountry {
                        
                        if (country as! NSDictionary).value(forKey: "id") as? Int == countryId {
                            
                            strCountryID = String(format: "%@", (country as! NSDictionary).value(forKey: "id") as! CVarArg) as NSString
                            
                            strCountryName = String(format: "%@", (country as! NSDictionary).value(forKey: "country") as! CVarArg) as NSString
                            
                            self?.GetStateList()
                        }
                    }
                  //  countries = dic["data"] as! NSArray
                    
                    hud.dismiss()
                    
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



    func GetStateList()
    {
      //  DicParameters = ["/":strCountryID] as [String : String]
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getStateList(), completion: { [weak self] response in
            print(response)
            let errorCheck = response["success"] as! Bool
            
            if errorCheck
            {
                //                    self?.obj.responseFromJson(dic:response)
                
                var dic = NSDictionary()
                dic = response as NSDictionary
                self?.arrStates = dic["data"] as! NSArray
                
                let stateId = addressDic .value(forKey: "state_id") as? Int
               
                for state in self!.arrStates {
                    
                    if (state as! NSDictionary).value(forKey: "id") as? Int == stateId {
                        
                        strStateName = String(format: "%@", (state as! NSDictionary).value(forKey: "state") as! CVarArg) as NSString
                        
                        self!.getTXtData()
                        

                    }
                }
                
                hud.dismiss()
                

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
