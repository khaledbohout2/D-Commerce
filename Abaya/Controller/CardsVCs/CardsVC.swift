////
////  CardsVC.swift
////  Abaya
////
////  Created by Khaled Bohout on 11/19/19.
////  Copyright © 2019 Khaled Bohout. All rights reserved.
////
//
//import UIKit
//
//class CardsVC: UIViewController {
//
//    @IBOutlet weak var btnAddCard: MainButton!
//
//    @IBOutlet weak var viewLineBottom: UIView!
//
//    @IBOutlet weak var viewLineTop: UIView!
//
//    @IBOutlet weak var lblCardsCount: UILabel!
//    
//    @IBOutlet weak var lblYourCards: UILabel!
//
//    @IBOutlet weak var tblCards: UITableView!
//
//     var arrCards = NSMutableArray()
//    // var strDeleteId = NSString()
//
//     var selectedIndex = NSInteger()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tblCards.register(UINib(nibName: "CardsCell", bundle: nil), forCellReuseIdentifier: "CardsCell")
//        tblCards.allowsMultipleSelection = false
//           setupNavButtons()
//
//    }
//
//
//    @IBAction func btnAddNewCardTapped(_ sender: Any) {
//
//        let obj = self.storyboard!.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardVC
//        self.navigationController?.pushViewController(obj, animated: true)
//    }
//
//    func GetUserCards()
//    {
//        DicParameters = [:]
//        hud.textLabel.text = "Loading"
//        hud.show(in: self.view)
//        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getUserCards(), completion: { [weak self] response in
//            let errorCheck = response["success"] as! Bool
//
//            if errorCheck
//            {
//
//
//                let arrdata = (response["data"] as! NSArray)
//                self?.arrCards = arrdata.mutableCopy() as! NSMutableArray
//                print(self?.arrCards as Any)
//
//                self?.tblCards.reloadData()
//                hud.dismiss()
//                self?.lblCardsCount.text = String(self!.arrCards.count)
//                self?.lblYourCards.isHidden = false
//               // self?.lblAddressNo.isHidden = false
//                self?.viewLineTop.isHidden = false
//                self?.viewLineBottom.isHidden = false
//                self?.btnAddCard.isHidden = false
//            }
//            else
//            {
//                hud.dismiss()
//                Alert.Show(title:"something wrong", mesage:"Please try again.", viewcontroller:self!)
//            }
//            }, failure: { [weak self] failResponse in
//                hud.dismiss()
//                Alert.Show(title:"network error", mesage:"Please try again.", viewcontroller:self!)
//        })
//    }
//
//
//}
//
//extension CardsVC {
//
//    func setupNavButtons() {
//
//
//        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.view.backgroundColor = UIColor.lightGray
//        self.navigationController?.navigationBar.tintColor = UIColor.black
//        self.title = "Addresses"
//
//
//        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backAction))
//
//        navigationItem.leftBarButtonItem = backButton
//
//        navigationController?.navigationBar.setNeedsLayout()
//    }
//
//    @objc func backAction()
//    {
//        self.navigationController?.popViewController(animated: true)
//    }
//
//}
//
//extension CardsVC: UITableViewDataSource, UITableViewDelegate
//{
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//    {
//        return 190
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return arrCards.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CardsCell", for: indexPath as IndexPath) as! CardsCell
//        cell.selectionStyle = .none
//
//         var dic = NSDictionary()
//        dic = arrCards[indexPath.row] as! NSDictionary
//        print(dic)
//
//        let layer = UIView(frame: CGRect(x: 319, y: 382, width: 18, height: 18))
//        layer.layer.borderWidth = 1
//        layer.layer.borderColor = UIColor(red:0.84, green:0.82, blue:0.82, alpha:1).cgColor
//        cell.addSubview(layer)
//
//       // cell.btnDelete.tag = indexPath.row
//      //  cell.btnDelete.addTarget(self, action: #selector(buttonDelete), for: .touchUpInside)
//        cell.btnEdit.addTarget(self, action: #selector(buttonEdit), for: .touchUpInside)
//
//        cell.btnCheckMark.tag = indexPath.row
//        cell.btnCheckMark.addTarget(self, action: #selector(buttonCheckMark), for: .touchUpInside)
//
//        let strFirstname  = dic .object(forKey: "first_name") as?String
//        let strLastname  = dic .object(forKey: "last_name") as?String
//
//        cell.lblName.text = strFirstname! + " " + strLastname!
//        cell.lblAddress1.text = dic .object(forKey: "address1") as?String
//        cell.lblAddress2.text = dic .object(forKey: "address2") as?String
//        cell.lblMobile.text = dic .object(forKey: "mobile") as?String
//        if(indexPath.row == selectedIndex)
//        {
//
//            let tickedImg = UIImage(named: "tick_mark.png")
//            cell.btnCheckMark.setImage(tickedImg, for: UIControl.State.normal)
//            cell.btnEdit .setTitleColor(UIColor.white, for: UIControl.State.normal)
//            cell.btnDelete .setTitleColor(UIColor.white, for: UIControl.State.normal)
//            cell.viewLineBottom.isHidden = true
//            cell.viewBottom.backgroundColor = UIColor.black
//        }
//        else
//        {
//
//            let tickedImg = UIImage(named: "ic_radio_button_unchecked")
//            cell.btnCheckMark.setImage(tickedImg, for: UIControl.State.normal)
//            cell.viewBottom.backgroundColor = UIColor.white
//            cell.btnEdit .setTitleColor(UIColor.black, for: UIControl.State.normal)
//            cell.btnDelete .setTitleColor(UIColor.black, for: UIControl.State.normal)
//            cell.viewLineBottom.isHidden = false
//        }
//
//        return cell
//    }
//
//
//
//}
