//
//  PaymentVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/10/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//
import UIKit

class PaymentVC: UIViewController {
    
    @IBOutlet weak var sepLast: UIView!
    @IBOutlet weak var imgInfo: UIImageView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var lblCreditCard: UILabel!
    @IBOutlet weak var lblKnet: UILabel!
    @IBOutlet weak var lblCashOnDelivery: UILabel!
    @IBOutlet weak var imgCashOnDelivery: UIImageView!
    @IBOutlet weak var imgKnet: UIImageView!
    @IBOutlet weak var imgCricleCash: UIImageView!
    @IBOutlet weak var imgCricleKnet: UIImageView!
    @IBOutlet weak var imgCricleCredit: UIImageView!
    @IBOutlet weak var imgCreditCard: UIImageView!
    @IBOutlet weak var btnCreditCard: UIButton!
    @IBOutlet weak var btnKnet: UIButton!
    @IBOutlet weak var btnCashOnDelivery: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavButtons()
        
        self.imgCashOnDelivery.alpha = 0.25;
        self.lblCashOnDelivery.alpha = 0.25;
        self.imgCricleCash.alpha = 0.25;
        self.btnCashOnDelivery.alpha = 0.25;
        
        self.imgCreditCard.alpha = 0.25;
        self.lblCreditCard.alpha = 0.25;
        self.imgCricleCredit.alpha = 0.25;
        self.btnCreditCard.alpha = 0.25;
        
        self.imgKnet.alpha = 0.25;
        self.lblKnet.alpha = 0.25;
        self.imgCricleKnet.alpha = 0.25;
        self.btnKnet.alpha = 0.25;
     
    }
    
    
    @IBAction func btnContinueClicked(_ sender: Any) {
        
        if btnCashOnDelivery.isSelected {
            
        makeorder(type: 1)

            
        } else if btnCreditCard.isSelected  {
            
            makeorder(type: 2)
            
        } else if btnKnet.isSelected {
            
            makeorder(type: 2)
        }
            
      else  {
            
            Alert.Show(title: NSLocalizedString("Payment Method Missing", comment: "") , mesage: NSLocalizedString("please select payment method", comment: "") , viewcontroller: self)
        }

    }
    
    @IBAction func btnCashOnDeliveryClicked(_ sender: Any) {
        
        
        
        lblInfo.text =  NSLocalizedString("Total amount of the order invoice will be due on delivery of your order.", comment: "")
        
        imgCricleCash.image = #imageLiteral(resourceName: "tick_mark")
        imgCricleCredit.image = #imageLiteral(resourceName: "ic_radio_button_unchecked")
        imgCricleKnet.image = #imageLiteral(resourceName: "ic_radio_button_unchecked")
        
        
        self.imgCashOnDelivery.alpha = 1.0;
        self.lblCashOnDelivery.alpha = 1.0;
        self.imgCricleCash.alpha = 1.0;
        self.btnCashOnDelivery.alpha = 1.0;
        
        self.imgCreditCard.alpha = 0.25;
        self.lblCreditCard.alpha = 0.25;
        self.imgCricleCredit.alpha = 0.25;
         self.btnCreditCard.alpha = 0.25;
        
        self.imgKnet.alpha = 0.25;
        self.lblKnet.alpha = 0.25;
        self.imgCricleKnet.alpha = 0.25;
        self.btnKnet.alpha = 0.25;
        
        btnCashOnDelivery.isSelected = true
        btnKnet.isSelected = false
        btnCreditCard.isSelected = false
    }
    
    @IBAction func btnKnetClicked(_ sender: Any) {
        
        lblInfo.text = NSLocalizedString("You will be redirected to KNET payment gateway to complete your purchase securely.", comment: "")
        
    
        imgCricleCash.image = #imageLiteral(resourceName: "ic_radio_button_unchecked")
        imgCricleCredit.image = #imageLiteral(resourceName: "ic_radio_button_unchecked")
        imgCricleKnet.image = #imageLiteral(resourceName: "tick_mark")
        
        
        self.imgCashOnDelivery.alpha = 0.25;
        self.lblCashOnDelivery.alpha = 0.25;
        self.imgCricleCash.alpha = 0.25;
        self.btnCashOnDelivery.alpha = 0.25;
        
        
        self.imgCreditCard.alpha = 0.25;
        self.lblCreditCard.alpha = 0.25;
        self.imgCricleCredit.alpha = 0.25;
        self.btnCreditCard.alpha = 0.25;
        
        self.imgKnet.alpha = 1.0;
        self.lblKnet.alpha = 1.0;
        self.imgCricleKnet.alpha = 1.0;
        self.btnKnet.alpha = 1.0;
        
        btnKnet.isSelected = true
        btnCreditCard.isSelected = false
        btnCashOnDelivery.isSelected = false
    }
    @IBAction func btnCreditCardClicked(_ sender: Any) {
        
        imgCricleCash.image = #imageLiteral(resourceName: "ic_radio_button_unchecked")
        imgCricleCredit.image = #imageLiteral(resourceName: "tick_mark")
        imgCricleKnet.image = #imageLiteral(resourceName: "ic_radio_button_unchecked")
        
        self.imgCashOnDelivery.alpha = 0.25;
        self.lblCashOnDelivery.alpha = 0.25;
        self.imgCricleCash.alpha = 0.25;
        self.btnCashOnDelivery.alpha = 0.25;
        
        self.imgCreditCard.alpha = 1.0;
        self.lblCreditCard.alpha = 1.0;
        self.imgCricleCredit.alpha = 1.0;
        self.btnCreditCard.alpha = 1.0;
        
        
        self.imgKnet.alpha = 0.25;
        self.lblKnet.alpha = 0.25;
        self.imgCricleKnet.alpha = 0.25;
        self.btnKnet.alpha = 0.25;
        
        btnCreditCard.isSelected = true
        btnCashOnDelivery.isSelected = false
        btnKnet.isSelected = false
    }
    
    func makeorder(type: Int) {
        
        hud.textLabel.text = NSLocalizedString("loading", comment: "")
        hud.show(in: self.view)
        
        let dic = addressDic
        
        let address1 = dic .value(forKey: "address1") as! String
        let address2 = dic .value(forKey: "address2") as! String
        let city = dic .value(forKey: "city") as! String
        let country_id = String(dic .value(forKey: "country_id") as! Int)
        let first_name = dic .value(forKey: "first_name") as! String
        let last_name = dic .value(forKey: "last_name") as! String
        let mobile = dic .value(forKey: "mobile") as! String
        let postcode = dic .value(forKey: "postcode") as! String
        let state_id = String(dic .value(forKey: "state_id") as! Int)
        let order_type = String(type)

        
        let par = ["billing_first_name" : first_name,
               "billing_last_name" : last_name,
            "billing_mobile" : mobile,
            "billing_address1" : address1,
            "billing_address2" : address2,
            "billing_postcode" : postcode,
            "billing_country_id" : country_id,
            "billing_state_id" : state_id,
            "billing_city" : city,
            "shipping_first_name" : first_name,
            "shipping_last_name" : last_name,
            "shipping_mobile" : mobile,
            "shipping_address1" : address1,
            "shipping_address2" : address2,
            "shipping_postcode" : postcode,
            "shipping_country_id" : country_id,
            "shipping_state_id" : state_id,
            "shipping_city" : city,
            "order_type" : order_type]
        
        ApiBaseClass.apiCallingMethode(url: ApiBaseClass.saveOrder(), parameter: par, completion: { (response) in
            
            
            
            if type == 1 {
                
                hud.dismiss()
                print("saved order success \(response)")
                let obj = self.storyboard!.instantiateViewController(withIdentifier: "OrderConfirmVC") as! OrderConfirmVC
                self.navigationController?.pushViewController(obj, animated: true)
                
            } else if type == 2 {
                
                hud.dismiss()
                
                var dic = NSDictionary()
                
                dic = response as NSDictionary
                
                let url = (dic["data"] as! String)
                
                let obj = self.storyboard!.instantiateViewController(withIdentifier: "GatwayVC") as! GatwayVC
                
                obj.url = url
                
                self.navigationController?.pushViewController(obj, animated: true)
            }
            

            
        }) { (error) in
            
            hud.dismiss()
            
            Alert.Show(title:NSLocalizedString("something wrong", comment: ""), mesage: NSLocalizedString(error as! String, comment: ""), viewcontroller:self)
            
            print("khaled: error making request \(error)")
        }
    }
}

// MARK:- Navigation
extension PaymentVC {
    
    func setupNavButtons() {
        
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.title = NSLocalizedString("Checkout", comment: "")
        
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backAction))
        
        navigationItem.leftBarButtonItem = backButton
        
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    @objc func backAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
