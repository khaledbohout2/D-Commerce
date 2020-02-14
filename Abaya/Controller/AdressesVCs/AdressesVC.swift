//
//  AddressesViewcontroller.swift
//  Abaya
//
//  Created by Rajendra Kumar on 10/04/19.
//  Copyright © 2019 Kareem Mohammed. All rights reserved.
//

import UIKit

class AdressesVC: UIViewController {
    
    @IBOutlet weak var btnAddAddress: MainButton!
    @IBOutlet weak var viewLineBottom: UIView!
    @IBOutlet weak var viewLineTop: UIView!
    @IBOutlet weak var lblAddressCount: UILabel!
    @IBOutlet weak var lblYourAddress: UILabel!
    @IBOutlet weak var lblAddressNo: UILabel!
    @IBOutlet weak var tblAddresses: UITableView!
    var arrAddresses = NSMutableArray()
   // var strDeleteId = NSString()
    
    var selectedIndex = NSInteger()
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBySwipe()
        
        tblAddresses.register(UINib(nibName: "AddressesCell", bundle: nil), forCellReuseIdentifier: "AddressesCell")
      tblAddresses.allowsMultipleSelection = false
         setupNavButtons()
    }
    override func viewWillAppear(_ animated: Bool) {
        GetUserAddress()

    }
    
    func backBySwipe() {
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        self.view.addGestureRecognizer(gesture)
        self.tblAddresses.addGestureRecognizer(gesture)
    }
    

    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {

        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnAddAddressClicked(_ sender: Any) {
        
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "AddAddressVC") as! AddAddressVC
        self.navigationController?.pushViewController(obj, animated: true)
        
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
               // print(self?.arrAddresses as Any)
               
                self?.tblAddresses.reloadData()
                hud.dismiss()
                self?.lblAddressNo.text = String(self!.arrAddresses.count)
                self?.lblYourAddress.isHidden = false
                self?.lblAddressNo.isHidden = false
                self?.viewLineTop.isHidden = false
                self?.viewLineBottom.isHidden = false
                self?.btnAddAddress.isHidden = false
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
    
    func DeleteUserAddress()
    {
        
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)

        ApiBaseClass.apiCallingWithDeleteMethode(url:ApiBaseClass.deleteUserAddresses(), completion: { [weak self] response in
            
            hud.dismiss()
            self!.GetUserAddress()
            self?.tblAddresses.reloadData()
            
            

            }, failure: { [weak self] failResponse in
                hud.dismiss()
                Alert.Show(title:"", mesage:.no_internet, viewcontroller:self!)
        })
    }
    
}


// MARK: - Table View Data Source

extension AdressesVC: UITableViewDataSource, UITableViewDelegate
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
        print("Adress is \(dic)")
        
//        let layer = UIView(frame: CGRect(x: 319, y: 382, width: 18, height: 18))
//        layer.layer.borderWidth = 1
//        layer.layer.borderColor = UIColor(red:0.84, green:0.82, blue:0.82, alpha:1).cgColor
//        cell.addSubview(layer)
        
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(buttonDelete), for: .touchUpInside)
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
    
    @objc func buttonDelete(sender: UIButton) {
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tblAddresses)
        let indexPath = self.tblAddresses.indexPathForRow(at: buttonPosition)
        var dicuserDetail = NSDictionary()
        dicuserDetail = self.arrAddresses[(indexPath?.row)!] as! NSDictionary
        strDeleteId = String(format: "%@",dicuserDetail.value(forKey: "id") as! CVarArg) as String
       // print(strDeleteId)
        DeleteUserAddress()
    }
    
    @objc func buttonCheckMark(sender: UIButton){
        _ = sender.superview?.superview as? AddressesCell
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tblAddresses)
        let indexPath = self.tblAddresses.indexPathForRow(at: buttonPosition)
        selectedIndex = indexPath!.row;

        tblAddresses.reloadData()
        
    }
    
    }



// MARK:- Navigation
extension AdressesVC {
    
    func setupNavButtons() {
        
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.title = NSLocalizedString("Addresses", comment: "") 
        
        
        let backButton = UIBarButtonItem(image: UIImage(named: NSLocalizedString("back_arrow", comment: "")), style: .plain, target: self, action: #selector(backAction))
        
        navigationItem.leftBarButtonItem = backButton
        
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    @objc func backAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}
