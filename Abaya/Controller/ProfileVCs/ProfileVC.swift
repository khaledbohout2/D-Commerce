//
//  ProfileViewController.swift
//  Abaya
//
//  Created by Chandar on 17/03/19.
//  Copyright © 2019 Kareem Mohammed. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var tblProfile: UITableView!
    @IBOutlet weak var viewPopUp: UIView!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnLogout: UIButton!
    
    
    var strFirstName = NSString()
    var strLastName = NSString()

    
    
    let arrImages = ["orders_icon", "addr_icon", "saved_cards_icon", "notification_icon", "wishlist_icon_gray copy"]
    let arrList = ["My Order", "Addresses", "Saved Cards", "Notifications", "Wishlist"]
    
    var arryList = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBySwipe()
        setupNavButtons()
        
        
        tblProfile.delegate = self
        tblProfile.dataSource = self
        
        
        dicLoginUserData = (UserDefaults.standard.object(forKey: "dictionaryKey") as? NSDictionary)!
        dicUserProfile =  dicLoginUserData .object(forKey: "user") as! NSDictionary
        strFirstName =  dicUserProfile .object(forKey: "first_name") as! NSString
        strFirstName =  dicUserProfile["first_name"] as! NSString
        strLastName =  dicUserProfile["last_name"] as! NSString
        lblName.text = (strFirstName as String) + (" " as String) + (strLastName as String)
        lblEmail.text =  dicUserProfile["email"] as! NSString as String
        imgProfile.setImage(string: "\(strFirstName) \(strLastName)", color: UIColor.black, circular: true, stroke: true)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        
        viewPopUp.isHidden = true
        setupNavButtons()
        
        
        
        tblProfile.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")

    }
    
    func backBySwipe() {
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        let lang = Locale.preferredLanguages[0]
        if lang == "en" {
        gesture.direction = .right
        } else if lang == "ar" {
            gesture.direction = .left
        }

        self.tblProfile.addGestureRecognizer(gesture)
        self.view.addGestureRecognizer(gesture)
    }
    

    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {

        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func editBtnClicked(_ sender: Any) {
        
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.viewPopUp.isHidden = true
        })
        
        let obj = self.storyboard!.instantiateViewController(withIdentifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(obj, animated: true)
        
    }
    
    @IBAction func logoutBtnClicked(_ sender: Any) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.viewPopUp.isHidden = false
        })
        
        logOut()
        

    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.viewPopUp.isHidden = true
        })
    }
    
    func logOut() {
        
        hud.textLabel.text = NSLocalizedString("loading", comment: "")
        hud.show(in: self.view)
        DicParameters = [:]
        
         
        
         
        ApiBaseClass.apiCallingMethode(url:ApiBaseClass.logOutFromApp(), parameter: DicParameters, completion: { [weak self] response in
             
             let errorCheck = response["success"] as! Bool
             
             if errorCheck
             {
                
                let domain = Bundle.main.bundleIdentifier!
                UserDefaults.standard.removePersistentDomain(forName: domain)
                UserDefaults.standard.synchronize()

                
                let obj = self?.storyboard!.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                self?.navigationController?.pushViewController(obj, animated: true)
                
                 
                // print(dicData)
                 
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

extension ProfileVC: UITableViewDataSource, UITableViewDelegate
{
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
        {
            return 54
        }
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
        }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath as IndexPath) as! ProfileCell
            cell.selectionStyle = .none
    
    
    cell.btnNext.tag = indexPath.row
    cell.btnNext.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)

    
    
     cell.imgList.image = UIImage(named: arrImages[indexPath.row])
     cell.lblList.text = NSLocalizedString(arrList[indexPath.row], comment: "")
       
            
            return cell
        }
    @objc func buttonSelected(sender: UIButton){
        let button = sender 
        let cell = button.superview?.superview as? UITableViewCell
        let indexPath = tblProfile.indexPath(for: cell!)
        //print(indexPath?.row as Any)
        
        if (indexPath?.row == 1) {
            
            let obj = self.storyboard!.instantiateViewController(withIdentifier: "AddressesViewcontroller") as! AdressesVC
            self.navigationController?.pushViewController(obj, animated: true)
        }
      else
        if (indexPath?.row == 4) {
            let obj = self.storyboard!.instantiateViewController(withIdentifier: "WishListViewcontroller") as! WishListVC
            self.navigationController?.pushViewController(obj, animated: true)
        } else
            if (indexPath?.row == 0) {
                let obj = self.storyboard!.instantiateViewController(withIdentifier: "OrdersVC") as! OrdersVC
                self.navigationController?.pushViewController(obj, animated: true)
        }
        //else
//            if (indexPath?.row == 2) {
//                let obj = self.storyboard!.instantiateViewController(withIdentifier: "CardsVC") as! CardsVC
//                self.navigationController?.pushViewController(obj, animated: true)
//        }
        
        
    }
 func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0) {
            
        }
        else    if (indexPath.row == 1) {
            
        }
        else    if (indexPath.row == 2) {
            
        }
        else    if (indexPath.row == 3) {
            
        }
        else    if (indexPath.row == 4) {
            let obj = self.storyboard!.instantiateViewController(withIdentifier: "WishListViewcontroller") as! WishListVC
            self.navigationController?.pushViewController(obj, animated: true)
        }
        
   
    }
    
    func imageWith(name: String?) -> UIImage? {
         let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
         let nameLabel = UILabel(frame: frame)
         nameLabel.textAlignment = .center
         nameLabel.backgroundColor = .lightGray
         nameLabel.textColor = .white
         nameLabel.font = UIFont.boldSystemFont(ofSize: 40)
         nameLabel.text = name
         UIGraphicsBeginImageContext(frame.size)
          if let currentContext = UIGraphicsGetCurrentContext() {
             nameLabel.layer.render(in: currentContext)
             let nameImage = UIGraphicsGetImageFromCurrentImageContext()
             return nameImage
          }
          return nil
    }
    
    
    }

// MARK:- Navigation
extension ProfileVC {
    
    func setupNavButtons() {
        
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.title = NSLocalizedString("Profile", comment: "")
        
        
        
        let backButton = UIBarButtonItem(image: UIImage(named: NSLocalizedString("back_arrow", comment: "")), style: .plain, target: self, action: #selector(backAction))
        
        navigationItem.leftBarButtonItem = backButton
        
        let favButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "info_icon_new"), style: .plain, target: self, action:#selector(notificationAction))
     
        navigationItem.rightBarButtonItems = [favButtonItem]
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    @objc func backAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func notificationAction()
    {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.viewPopUp.isHidden = false
        })
    }
}


