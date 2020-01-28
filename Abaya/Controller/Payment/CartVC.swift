//
//  CartVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/09/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import SDWebImage

class CartVC: UIViewController {
    
    var arrCart  = NSMutableArray()
    var dicBillInfo = NSDictionary()
    
    @IBOutlet weak var tblCart: UITableView!
    
   // @IBOutlet weak var scrollView: UIScrollView!
    
   // @IBOutlet weak var contantView: UIView!
    
   // @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    //@IBOutlet weak var contantViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.view.frame =  CGRect(0, 0, self.view.frame.size.width, self.view.frame.size.height+1000)
        
        GetCartList()
        
        self.tblCart.isHidden = true
        
        self.tblCart.tableFooterView = UIView()

        tblCart.register(UINib(nibName: "CartCell", bundle: nil), forCellReuseIdentifier: "CartCell")
        tblCart.allowsMultipleSelection = false

       setupNavButtons()
      // GetCartList()
    }
    

    @IBAction func viewTapped(_ sender: Any) {
        self.view.endEditing(true)
    }
    
        override func viewDidLayoutSubviews()
        {
            
//            contantView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.tblCart.frame.size.height)
//
//            scrollView.contentSize = CGSize(width: self.contantView.frame.size.width, height: self.contantView.frame.size.height)
//            self.contantViewHeight?.constant = self.contantView.frame.size.height
            
            
        //    contantView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.tblCart.frame.size.height)
           // contentViewHeight.constant = self.tblCart.frame.size.height
            

    //        self.view.frame = (frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height+600))
            
        }
    
    func GetCartList()
        
    {
        DicParameters = [:]
        
        
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getCartList(), completion: { [weak self] response in
            let errorCheck = response["success"] as! Bool
            
            if errorCheck
            {
                
                var dic = NSDictionary()
                 dic = response as NSDictionary
              //  print("cart list is\(dic)")
                

                if let dicData = (dic["data"] as? NSDictionary) {
                
               // print("khaled123 \(dicData)")
                
                self!.dicBillInfo = (dicData["billInfo"] as! NSDictionary)
                
                
                let arrdata = (dicData["cartInfo"] as! NSArray)
                self?.arrCart = arrdata.mutableCopy() as! NSMutableArray
               // print(self?.arrCart as Any)
                self?.tblCart.reloadData()
                self?.tblCart.isHidden = false
                    
                 hud.dismiss()
            
                } else if (dic["data"] as? NSArray) != nil {
                    
                    hud.dismiss()
                    
                    self?.tblCart.isHidden = true
                    Alert.Show(title: "", mesage: "cart is empty", viewcontroller: self!)

            
            }
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
    
    func DeleteCart()
        
    {
       // DicParameters = ["":strDeleteId] as [String : String]
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiBaseClass.apiCallingWithDeleteMethode(url:ApiBaseClass.deleteCartApi(), completion: { [weak self] response in
            
            
            //print("khaled: \(response)")

                hud.dismiss()
            
                self!.GetCartList()

                self!.tblCart.reloadData()
            
            
                Alert.Show(title:"", mesage: NSLocalizedString("item deleted", comment: ""), viewcontroller:self!)
            

            }, failure: { [weak self] failResponse in
                hud.dismiss()
                Alert.Show(title:"", mesage:.no_internet, viewcontroller:self!)
        })
    }
    
}

// MARK: - Table View Data Source

extension CartVC: UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 1{
                let footerView = UIView(frame: CGRect(x: 0, y: 500, width: tableView.frame.size.width, height: tblCart.contentSize.height+500))
        footerView.backgroundColor = UIColor.white
        
        
        let textLayer = UILabel(frame: CGRect(x: 25, y: 20, width: 62, height: 18))
        textLayer.lineBreakMode = .byWordWrapping
        textLayer.numberOfLines = 0
        textLayer.textColor = UIColor.darkGray
        let textContent = NSLocalizedString("Subtotal", comment: "") 
        let textString = NSMutableAttributedString(string: textContent, attributes: [
            kCTFontAttributeName as NSAttributedString.Key: UIFont(name: "Montserrat-SemiBold", size: 14)!
            ])
        let textRange = NSRange(location: 0, length: textString.length)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.29
        textString.addAttribute(kCTParagraphStyleAttributeName as NSAttributedString.Key, value:paragraphStyle, range: textRange)
        textLayer.attributedText = textString
        textLayer.sizeToFit()
        footerView.addSubview(textLayer)
        
        
        
        
        let textSubtotal = UILabel(frame: CGRect(x: self.view.frame.size.width-125, y: 20, width: 100, height: 18))
        textSubtotal.lineBreakMode = .byWordWrapping
        textSubtotal.numberOfLines = 0
        textSubtotal.textColor = UIColor.darkGray
        textSubtotal.textAlignment = .left
       // print(dicBillInfo)
        if let subtotal = dicBillInfo .object(forKey: "subTotal") as? String {
         let textContentsub = NSLocalizedString("KD ", comment: "") + "\(subtotal)"
        let textsubString = NSMutableAttributedString(string: textContentsub, attributes: [
            kCTFontAttributeName as NSAttributedString.Key: UIFont(name: "Montserrat-Medium", size: 14)!
            ])
        textSubtotal.attributedText = textsubString
        }
        textSubtotal.sizeToFit()
        footerView.addSubview(textSubtotal)
        
        
        
        
        let textShippingvalue = UILabel(frame: CGRect(x: self.view.frame.size.width-125, y: 60, width: 89, height: 18))
        textShippingvalue.lineBreakMode = .byWordWrapping
        textShippingvalue.numberOfLines = 0
        textShippingvalue.textColor = UIColor.darkGray
        textShippingvalue.textAlignment = .left
        if let delivery_charge = dicBillInfo .object(forKey: "delivery_charge") as? Int {
        let textContentsub = NSLocalizedString("KD ", comment: "") + "\(delivery_charge)"
        let textsubString = NSMutableAttributedString(string: textContentsub, attributes: [
            kCTFontAttributeName as NSAttributedString.Key: UIFont(name: "Montserrat-Medium", size: 14)!
            ])
        textShippingvalue.attributedText = textsubString
        }
        textShippingvalue.sizeToFit()
        footerView.addSubview(textShippingvalue)
        
        

        let textShipping = UILabel(frame: CGRect(x: 25, y: 60, width: 89, height: 18))
        textShipping.lineBreakMode = .byWordWrapping
        textShipping.numberOfLines = 0
        textShipping.textColor = UIColor.darkGray
        textShipping.textAlignment = .left
        let textshipping = NSLocalizedString("Shipping", comment: "")
        let textsString = NSMutableAttributedString(string: textshipping, attributes: [
            kCTFontAttributeName as NSAttributedString.Key: UIFont(name: "Montserrat-SemiBold", size: 14)!
            ])
        textShipping.attributedText = textsString
        textShipping.sizeToFit()
        footerView.addSubview(textShipping)
        
        
        
        let textVat = UILabel(frame: CGRect(x: self.view.frame.size.width-125, y: 100, width: 89, height: 18))
        textVat.lineBreakMode = .byWordWrapping
        textVat.numberOfLines = 0
        textVat.textColor = UIColor.darkGray
        textVat.textAlignment = .left
        if let delivery_charge = dicBillInfo .object(forKey: "vat") as? String {
        let textContentsub = "\(delivery_charge)"
        let textsubString = NSMutableAttributedString(string: textContentsub, attributes: [
            kCTFontAttributeName as NSAttributedString.Key: UIFont(name: "Montserrat-Medium", size: 14)!
            ])
        textVat.attributedText = textsubString
        }
        textVat.sizeToFit()
        footerView.addSubview(textVat)
        
        

        let textVatPerc = UILabel(frame: CGRect(x: 25, y: 100, width: 120, height: 18))
        textVatPerc.lineBreakMode = .byWordWrapping
        textVatPerc.numberOfLines = 0
        textVatPerc.textColor = UIColor.darkGray
        textVatPerc.textAlignment = .left
        let textVatV = NSLocalizedString("Vat Percentage", comment: "")
        let textVatVS = NSMutableAttributedString(string: textVatV, attributes: [
            kCTFontAttributeName as NSAttributedString.Key: UIFont(name: "Montserrat-SemiBold", size: 14)!
            ])
        textVatPerc.attributedText = textVatVS
        textVatPerc.sizeToFit()
        footerView.addSubview(textVatPerc)
        
        
        let textVatNum = UILabel(frame: CGRect(x: self.view.frame.size.width-125, y: 140, width: 120, height: 18))
        textVatNum.lineBreakMode = .byWordWrapping
        textVatNum.numberOfLines = 0
        textVatNum.textColor = UIColor.darkGray
        textVatNum.textAlignment = .left
        if let delivery_charge = dicBillInfo .object(forKey: "vat_amount") as? String {
        let textContentsub = NSLocalizedString("KD ", comment: "") + "\(delivery_charge)"
        let textsubString = NSMutableAttributedString(string: textContentsub, attributes: [
            kCTFontAttributeName as NSAttributedString.Key: UIFont(name: "Montserrat-Medium", size: 14)!
            ])
        textVatNum.attributedText = textsubString
        }
        textVatNum.sizeToFit()
        footerView.addSubview(textVatNum)
        
        

        let textVatValue = UILabel(frame: CGRect(x: 25, y: 140, width: 120, height: 18))
        textVatValue.lineBreakMode = .byWordWrapping
        textVatValue.numberOfLines = 0
        textVatValue.textColor = UIColor.darkGray
        textVatValue.textAlignment = .left
        let textVatValueNum = NSLocalizedString("Vat Value", comment: "")
        let textVatValueNumm = NSMutableAttributedString(string: textVatValueNum, attributes: [
            kCTFontAttributeName as NSAttributedString.Key: UIFont(name: "Montserrat-SemiBold", size: 14)!
            ])
        textVatValue.attributedText = textVatValueNumm
        textVatValue.sizeToFit()
        footerView.addSubview(textVatValue)

        
        
        
        let layertop = UIView(frame: CGRect(x: 0, y: 1, width: self.view.frame.size.width, height: 1))
        layertop.backgroundColor = UIColor.black
        footerView.addSubview(layertop)
        
        
        let layer = UIView(frame: CGRect(x: 0, y: 180, width: self.view.frame.size.width, height: 1))
        layer.backgroundColor = UIColor.black
        footerView.addSubview(layer)
        
        
        
        
        let texttotal = UILabel(frame: CGRect(x: 25, y: 200, width: 89, height: 18))
        texttotal.lineBreakMode = .byWordWrapping
        texttotal.numberOfLines = 0
        texttotal.textColor = UIColor.darkGray
        texttotal.textAlignment = .left
        let texttotalv = NSLocalizedString("Total", comment: "")
        let texttotalString = NSMutableAttributedString(string: texttotalv, attributes: [
            kCTFontAttributeName as NSAttributedString.Key: UIFont(name: "Montserrat-SemiBold", size: 16)!
            ])
        texttotal.attributedText = texttotalString
        texttotal.sizeToFit()
        footerView.addSubview(texttotal)
        
        
        
        
        let texttotalAmount = UILabel(frame: CGRect(x: self.view.frame.size.width-125, y: 200, width: 110, height: 18))
        texttotalAmount.lineBreakMode = .byWordWrapping
        texttotalAmount.numberOfLines = 0
        texttotalAmount.textColor = UIColor.black
        texttotalAmount.textAlignment = .left
        if let delivery_charge = dicBillInfo .object(forKey: "totalPrice") as? String {
        let texttotalAmountm = NSLocalizedString("KD ", comment: "") + "\(delivery_charge)"
        let texttotalAmountString = NSMutableAttributedString(string: texttotalAmountm, attributes: [
            kCTFontAttributeName as NSAttributedString.Key: UIFont(name: "Montserrat-Medium", size: 14)!
            ])
        texttotalAmount.attributedText = texttotalAmountString
        }
        texttotalAmount.sizeToFit()
        footerView.addSubview(texttotalAmount)
        
        let layertotal = UIView(frame: CGRect(x: 0, y: 240, width: self.view.frame.size.width, height: 1))
        layertotal.backgroundColor = UIColor.black
        footerView.addSubview(layertotal)
        

        let textHave = UILabel(frame: CGRect(x: 25, y: 260, width: 214, height: 20))
        textHave.lineBreakMode = .byWordWrapping
        textHave.numberOfLines = 0
        textHave.textColor = UIColor.black
        textHave.textAlignment = .left
        let textHavetext = NSLocalizedString("HAVE COUPON CODE?", comment: "") 
        let texthaveString = NSMutableAttributedString(string: textHavetext, attributes: [
            kCTFontAttributeName as NSAttributedString.Key: UIFont(name: "Montserrat-SemiBold", size: 9)!
            ])
        textHave.attributedText = texthaveString
        textHave.sizeToFit()
        footerView.addSubview(textHave)
        

        let myTextField: UITextField = UITextField(frame: CGRect(x: 24, y: 274, width: 214, height: 38));
        footerView.addSubview(myTextField)
        myTextField.layer.borderWidth = 1
        myTextField.layer.masksToBounds = true
        myTextField.borderStyle = UITextField.BorderStyle.roundedRect
        myTextField.layer.cornerRadius = 3
        myTextField.layer.backgroundColor = UIColor.lightText.cgColor
        myTextField.backgroundColor = UIColor.white
        let myColor = UIColor.lightGray
        myTextField.layer.borderColor = myColor.cgColor
        myTextField.layer.borderWidth = 1.0
        myTextField.attributedPlaceholder = NSAttributedString(string:NSLocalizedString("Enter coupon code", comment: "")  , attributes: [
            .foregroundColor: UIColor.lightGray,
            .font: UIFont(name: "Montserrat-Regular", size: 12)!
            ])
        
        
        let btnApply = UIButton(frame: CGRect(x: 251, y: 274, width: 100, height: 38))
        btnApply.layer.cornerRadius = 4
        btnApply.backgroundColor = UIColor.black
        btnApply.layer.shadowOffset = CGSize(width: 0, height: 1)
        btnApply.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.1).cgColor
        let strtextApply = NSLocalizedString("Apply", comment: "")
        btnApply.titleLabel?.textColor = UIColor.white
        let textApply = NSMutableAttributedString(string: strtextApply, attributes: [
            kCTFontAttributeName as NSAttributedString.Key: UIFont(name: "Montserrat-SemiBold", size:14)!
            ])
        btnApply.setAttributedTitle(textApply, for: UIControl.State.normal)
        btnApply.layer.shadowOpacity = 1
        btnApply.layer.shadowRadius = 2
        footerView.addSubview(btnApply)
        
        
        let btnContinue = UIButton(frame: CGRect(x: 0, y: 350, width: self.view.frame.size.width, height: 38))
        btnContinue.layer.cornerRadius = 4
        btnContinue.backgroundColor = UIColor.clear
        btnContinue.layer.shadowOffset = CGSize(width: 0, height: 1)
        btnContinue.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.1).cgColor

        let yourAttributes : [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font :  UIFont(name: "Montserrat-Regular", size:12)!,
            NSAttributedString.Key.foregroundColor : UIColor.black,
            NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string:NSLocalizedString("Continue Shopping", comment: "") ,
                                                        attributes: yourAttributes)
        btnContinue.setAttributedTitle(attributeString, for: UIControl.State.normal)
       footerView.addSubview(btnContinue)
        
        
        let btnCkeckout = UIButton(frame: CGRect(x: 15, y: 390, width: self.view.frame.size.width-30, height: 45))
        btnCkeckout.layer.cornerRadius = 4
        btnCkeckout.backgroundColor = UIColor.black
        btnCkeckout.layer.shadowOffset = CGSize(width: 0, height: 1)
        btnCkeckout.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.1).cgColor
        let strtextCheck = NSLocalizedString("Proceed to Checkout →", comment: "")  
        btnCkeckout.titleLabel?.textColor = UIColor.white
        let textCheck = NSMutableAttributedString(string: strtextCheck, attributes: [
            kCTFontAttributeName as NSAttributedString.Key: UIFont(name: "Montserrat-SemiBold", size:16)!
            ])
        
        btnCkeckout.setAttributedTitle(textCheck, for: UIControl.State.normal)
        btnCkeckout.layer.shadowOpacity = 1
        btnCkeckout.layer.shadowRadius = 2
        footerView.addSubview(btnCkeckout)
        
       
       // btnCkeckout.tag = IndexPath.row
       btnCkeckout.addTarget(self, action: #selector(btnCkeckoutAction), for: .touchUpInside)
       btnContinue.addTarget(self, action: #selector(brnContinueAction), for: .touchUpInside )
        
        

        return footerView
        } else {
            
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 1 {
            
        return 450
            
        } else {
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        
        var height: CGFloat?
        
        if indexPath.section == 0 {
            
            height = 120
            
        } else {
            
            height = 0
        }
        
        return height!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
        return arrCart.count
            
        } else {
            
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath as IndexPath) as! CartCell
        cell.selectionStyle = .none
        
        var dic = NSDictionary()
        dic = arrCart[indexPath.row] as! NSDictionary
        
        let cartItemId = dic .value(forKey: "id") as! Int
        
        itemTODelete = String(cartItemId)
        
        cell.lblProductName.text = dic .object(forKey: "product_name") as?String
        
        cell.btnDelete.tag = indexPath.row
        
        cell.btnDelete.addTarget(self, action: #selector(buttonDelete), for: .touchUpInside)
        cell.btnPlus.addTarget(self, action: #selector(buttonPlus), for: .touchUpInside)
        cell.btnMinus.addTarget(self, action: #selector(buttonminus), for: .touchUpInside)
        
        let strQty = String(format: "%@", dic.value(forKey: "qty") as! CVarArg)
        cell.lblQty.text = strQty as String
        
        let strPrice = String(format: "%@%@","KD ", dic.value(forKey: "product_original_price") as! CVarArg)
        cell.lblProductPrice.text = strPrice as String
        
        let strimgUrl = .imagebaseURL + "products/" + (dic.value(forKey: "product_image") as? String)!
        let fileUrl = NSURL(string: strimgUrl)
        
        cell.imgProduct.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: "store_cover_two"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        
        
        return cell
            
        } else {
            
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //
    //        let cell: AddressesCell? = tblAddresses.cellForRow(at: indexPath) as? AddressesCell
    //        let tickedImg = UIImage(named: "tick_mark.png")
    //        cell?.btnCheckMark.setImage(tickedImg, for: UIControlState.normal)
    ////        tableView.deselectRow(at: indexPath, animated: true)
    //    }
    
    //    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    //
    //        let cell: AddressesCell? = tblAddresses.cellForRow(at: indexPath) as? AddressesCell
    //        let tickedImg = UIImage(named: "ic_radio_button_unchecked")
    //        cell?.btnCheckMark.setImage(tickedImg, for: UIControlState.normal)
    //
    //        tableView.deselectRow(at: indexPath, animated: false)
    //
    //    }
    
    
    
    
    @objc func btnCkeckoutAction(sender: UIButton){
        
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "CheckoutVC") as! CheckoutVC
        self.navigationController?.pushViewController(obj, animated: true)
    }
    @objc func brnContinueAction (sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeVC = storyboard.instantiateViewController(withIdentifier: "NewHomeVC") as! HomeVC
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    
    @objc func buttonDelete(sender: UIButton){
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tblCart)
        let indexPath = self.tblCart.indexPathForRow(at: buttonPosition)
        var dicuserDetail = NSDictionary()
        dicuserDetail = self.arrCart[(indexPath?.row)!] as! NSDictionary
        strDeleteId = String(format: "%@",dicuserDetail.value(forKey: "id") as! CVarArg) as String
      //  print(strDeleteId)
        DeleteCart()
    }
    
    @objc func buttonPlus(sender: UIButton){
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tblCart)
        let indexPath = self.tblCart.indexPathForRow(at: buttonPosition)
        var dicuserDetail = NSDictionary()
        dicuserDetail = self.arrCart[(indexPath?.row)!] as! NSDictionary
        strDeleteId = String(format: "%@",dicuserDetail.value(forKey: "product_id") as! CVarArg) as String
        let sku_id = String(format: "%@",dicuserDetail.value(forKey: "sku_id") as! CVarArg) as String
        var qty = String(format: "%@",dicuserDetail.value(forKey: "qty") as! CVarArg) as String
        
        var qtyint = Int(qty)!
        
        qtyint += 1
        
       // var myString = String(x)
        qty = String(qtyint)
        
        DicParameters = ["product_id" : strDeleteId as String, "sku_id" : sku_id , "qty" : qty ]
      //  print(strDeleteId)
        updateCart()
    }
    
    @objc func buttonminus(sender: UIButton){
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tblCart)
        let indexPath = self.tblCart.indexPathForRow(at: buttonPosition)
        var dicuserDetail = NSDictionary()
        dicuserDetail = self.arrCart[(indexPath?.row)!] as! NSDictionary
        strDeleteId = String(format: "%@",dicuserDetail.value(forKey: "product_id") as! CVarArg) as String
        let sku_id = String(format: "%@",dicuserDetail.value(forKey: "sku_id") as! CVarArg) as String
        var qty = String(format: "%@",dicuserDetail.value(forKey: "qty") as! CVarArg) as String
        
        var qtyint = Int(qty)!
        
        qtyint -= 1
        
       // var myString = String(x)
        qty = String(qtyint)
        
        DicParameters = ["product_id" : strDeleteId as String, "sku_id" : sku_id , "qty" : qty ]
      //  print(strDeleteId)
        updateCart()
    }
    
    func updateCart() {
        
       // DicParameters = [:]
        
        
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)
        ApiBaseClass.apiCallingMethode(url:ApiBaseClass.UpdateCartList(), parameter: DicParameters, completion: { [weak self] response in
            let errorCheck = response["success"] as! Bool
            
            if errorCheck
            {
                
                var dic = NSDictionary()
                 dic = response as NSDictionary
              //  print("cart list is\(dic)")
                

                if let dicData = (dic["data"] as? NSDictionary) {
                
               // print("khaled123 \(dicData)")
                
                self!.dicBillInfo = (dicData["billInfo"] as! NSDictionary)
                
                
                let arrdata = (dicData["cartInfo"] as! NSArray)
                self?.arrCart = arrdata.mutableCopy() as! NSMutableArray
               // print(self?.arrCart as Any)
                self?.tblCart.reloadData()
                self?.tblCart.isHidden = false
//                DispatchQueue.main.async {
//                    self!.tableHeight?.constant = self!.tblCart.contentSize.height
//                    self!.contantViewHeight?.constant = self!.tblCart.contentSize.height
//                }
                    
                 hud.dismiss()
            
                } else if (dic["data"] as? NSArray) != nil {
                    
                    hud.dismiss()
                    self!.tblCart.isHidden = true
                    
                    Alert.Show(title: "", mesage: NSLocalizedString("cart is empty", comment: "")
, viewcontroller: self!)

            
            }
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
 
}

// MARK:- Navigation
extension CartVC {
    
    func setupNavButtons() {
        
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        //self.title = "Cart"
        
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backAction))
        
        navigationItem.leftBarButtonItem = backButton
        
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    @objc func backAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
