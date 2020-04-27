//
//  CheckoutVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/09/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit

class CheckoutVC: UIViewController {
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var tblAddresses: UITableView!
    var arrAddresses = NSMutableArray()
    var selectedIndex = NSInteger()
    
    @IBOutlet weak var addressCount: UILabel!
    
    @IBOutlet weak var contintView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBySwipe()
        
        tblAddresses.register(UINib(nibName: "AddressesCell", bundle: nil), forCellReuseIdentifier: "AddressesCell")
        
        setupNavButtons()
        GetUserAddress()
        
        let indexPath = NSIndexPath(row: 0, section: 0)
        tblAddresses.selectRow(at: indexPath as IndexPath, animated: false, scrollPosition: .none)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func backBySwipe() {
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        let lang = Locale.preferredLanguages[0]
        if lang == "en" {
        gesture.direction = .right
        } else if lang == "ar" {
            gesture.direction = .left
        }

        self.view.addGestureRecognizer(gesture)
        self.tblAddresses.addGestureRecognizer(gesture)
    }
    

    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {

        self.navigationController?.popViewController(animated: true)
    }


    @IBAction func addNewAddressTapped(_ sender: Any) {
        
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "AddAddressVC") as! AddAddressVC
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    
    @IBAction func btnContinueClicked(_ sender: Any) {
        
        if arrAddresses.count == 0 {
            
            Alert.Show(title: NSLocalizedString("Address Is Missing", comment: ""), mesage: "Please Add Address To Make Order", viewcontroller: self)
            
        } else {
        
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "PaymentVC") as! PaymentVC
        self.navigationController?.pushViewController(obj, animated: true)
        }

       // print("btn continue clicked")
    }
    
    
    func GetUserAddress()
    {
        DicParameters = [:]
        hud.textLabel.text = NSLocalizedString("Loading", comment: "") 
        hud.show(in: self.view)
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getUserAddresses(), completion: { [weak self] response in
            let errorCheck = response["success"] as! Bool
            
            if errorCheck
            {
                
                var dic = NSDictionary()
                dic = response as NSDictionary
                
                let arrdata = (dic["data"] as! NSArray)
                self?.arrAddresses = arrdata.mutableCopy() as! NSMutableArray
                if self!.arrAddresses.count > 0 {
                addressDic = self?.arrAddresses[0] as! NSDictionary

                }
                self!.addressCount.text = "\(self!.arrAddresses.count)"
                self?.tblAddresses.reloadData()
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

}

// MARK: - Table View Data Source

extension CheckoutVC: UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 190
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAddresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressesCell", for: indexPath as IndexPath) as! AddressesCell
        cell.selectionStyle = .none
        
        var dic = NSDictionary()
        dic = arrAddresses[indexPath.row] as! NSDictionary
     //   print(dic)
        
        let layer = UIView(frame: CGRect(x: 319, y: 382, width: 18, height: 18))
        layer.layer.borderWidth = 1
        layer.layer.borderColor = UIColor(red:0.84, green:0.82, blue:0.82, alpha:1).cgColor
       // cell.addSubview(layer)
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(buttonDelete), for: .touchUpInside)
        cell.btnEdit.tag = indexPath.row
        cell.btnEdit.addTarget(self, action: #selector(buttonEdit), for: .touchUpInside)
        
        cell.btnCheckMark.tag = indexPath.row
        cell.btnCheckMark.addTarget(self, action: #selector(buttonCheckMark), for: .touchUpInside)
        
        let strFirstname  = dic .object(forKey: "first_name") as?String
        let strLastname  = dic .object(forKey: "last_name") as?String
        
        cell.lblName.text = strFirstname! + " " + strLastname!
        cell.lblAddress1.text = dic .object(forKey: "address1") as?String
        cell.lblAddress2.text = dic .object(forKey: "address2") as?String
        cell.lblMobile.text = dic .object(forKey: "mobile") as?String
        if(indexPath.row == selectedIndex)
        {
            
            let tickedImg = UIImage(named: "tick_mark.png")
            cell.btnCheckMark.setImage(tickedImg, for: UIControl.State.normal)
            cell.btnEdit .setTitleColor(UIColor.white, for: UIControl.State.normal)
            cell.btnDelete .setTitleColor(UIColor.white, for: UIControl.State.normal)
            cell.viewLineBottom.isHidden = true
            cell.viewBottom.backgroundColor = UIColor.black
        }
        else
        {
            
            let tickedImg = UIImage(named: "ic_radio_button_unchecked")
            cell.btnCheckMark.setImage(tickedImg, for: UIControl.State.normal)
            cell.viewBottom.backgroundColor = UIColor.white
            cell.btnEdit .setTitleColor(UIColor.black, for: UIControl.State.normal)
            cell.btnDelete .setTitleColor(UIColor.black, for: UIControl.State.normal)
            cell.viewLineBottom.isHidden = false
        }
        
        return cell
    }
    
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
            let cell: AddressesCell? = tblAddresses.cellForRow(at: indexPath) as? AddressesCell
            let tickedImg = UIImage(named: "tick_mark.png")
            cell?.btnCheckMark.setImage(tickedImg, for: UIControl.State.normal)
            selectedIndex = indexPath.row;
            
            var dic = NSDictionary()
            dic = arrAddresses[indexPath.row] as! NSDictionary
            addressDic = dic
            tblAddresses.reloadData()
            
            
            
        }
    
        func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    
            let cell: AddressesCell? = tblAddresses.cellForRow(at: indexPath) as? AddressesCell
            let tickedImg = UIImage(named: "ic_radio_button_unchecked")
            cell?.btnCheckMark.setImage(tickedImg, for: UIControl.State.normal)
            
    
            //tableView.deselectRow(at: indexPath, animated: false)
    
        }
    
    @objc func buttonDelete(sender: UIButton){
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tblAddresses)
        let indexPath = self.tblAddresses.indexPathForRow(at: buttonPosition)
        var dicuserDetail = NSDictionary()
        dicuserDetail = self.arrAddresses[(indexPath?.row)!] as! NSDictionary
        strDeleteId = String(format: "%@",dicuserDetail.value(forKey: "id") as! CVarArg) as String
       // print(strDeleteId)
        DeleteUserAddress()
        
    }
    func DeleteUserAddress()
    {
        //DicParameters = ["id":strDeleteId] as [String : String]
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)
       // print(strDeleteId)
        let url = "http://theblocksapp.com/api/deleteUserAddress/\(strDeleteId)"
       // print(url)
        ApiBaseClass.apiCallingWithDeleteMethode(url:url, completion: { [weak self] response in
            
            hud.dismiss()
            self!.GetUserAddress()
            self?.tblAddresses.reloadData()
            
            

            }, failure: { [weak self] failResponse in
                hud.dismiss()
                Alert.Show(title:"", mesage:.no_internet, viewcontroller:self!)
        })
    }
    
    @objc func buttonCheckMark(sender: UIButton){
        
        _ = sender.superview?.superview as? AddressesCell
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tblAddresses)
        let indexPath = self.tblAddresses.indexPathForRow(at: buttonPosition)
        selectedIndex = indexPath!.row;

        tblAddresses.reloadData()
        
    }
    
    @objc func buttonEdit(sender: UIButton) {
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tblAddresses)
        let indexPath = self.tblAddresses.indexPathForRow(at: buttonPosition)
        var dicuserDetail = NSDictionary()
        dicuserDetail = self.arrAddresses[(indexPath?.row)!] as! NSDictionary
        addressDic = dicuserDetail
        
        
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          let vc = storyboard.instantiateViewController(withIdentifier: "EditAddressVC") as! EditAddressVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

// MARK:- Navigation
extension CheckoutVC {
    
    func setupNavButtons() {
        
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.title = NSLocalizedString("Checkout", comment: "")
        
        
        let backButton = UIBarButtonItem(image: UIImage(named: NSLocalizedString("back_arrow", comment: "")), style: .plain, target: self, action: #selector(backAction))
        
        navigationItem.leftBarButtonItem = backButton
        
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    @objc func backAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
