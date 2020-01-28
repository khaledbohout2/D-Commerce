//
//  SliderMenuVC.swift
//
//  Created by Unify Systems on 13/09/18.
//  Copyright © 2018 Unify Systems. All rights reserved.
//

import UIKit
import SDWebImage

class SliderMenuVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblSlider: UITableView!
    
    var header : StretchHeader!
    
    var navigationView = UIView()

    let arrImages = ["orders_icon", "addr_icon", "saved_cards_icon", "notification_icon", "wishlist_icon_gray copy"]
    let arrCategories = ["Summer", "Winter"]
    let arrAccount = ["Country", "Language"]
    let arrImgAccount = ["flag_icon", "lang_icon"]
    let arrSupport = ["FAQs", "Customer Care","About"]
    let arrImgSupport = ["faq_icon", "customer_care_icon", "blocks_sidebar_icon"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GetCategoryApi()

        setupNavButtons()
        
        tblSlider.tableFooterView = UIView()
        tblSlider.estimatedRowHeight = 44.0
        tblSlider.rowHeight = UITableView.automaticDimension
        tblSlider.tableFooterView = UIView()
        tblSlider.delegate = self
        tblSlider.dataSource = self
        self.title = dicNewsDetail.value(forKey: "title") as? String
         tblSlider.register(UINib(nibName: "SliderCell", bundle: nil), forCellReuseIdentifier: "SliderCell")
         tblSlider.register(UINib(nibName: "AccountCell", bundle: nil), forCellReuseIdentifier: "AccountCell")
            self.setupHeaderView()

    }

 // MARK: - Tableview Delegate And Data Source
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "SliderCell", for: indexPath as IndexPath) as! SliderCell
            cell.selectionStyle = .none
            cell.nameLabel.text = NSLocalizedString(arrCategories[indexPath.row], comment: "")

                return cell
        }
            
        else  if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath as IndexPath) as! AccountCell
            cell.selectionStyle = .none

            if indexPath.row == 0 {

            }

            cell.nameLabel.text = NSLocalizedString(arrAccount[indexPath.row], comment: "")
             cell.imgIcon.image = UIImage(named: arrImgAccount[indexPath.row])
            if indexPath.row  == 0 {
                
                cell.flagImage.isHidden = false
            }
            return cell
        }
            
        else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath as IndexPath) as! AccountCell
            cell.selectionStyle = .none
            cell.nameLabel.text = NSLocalizedString(arrSupport[indexPath.row], comment: "")
            cell.imgIcon.image = UIImage(named: arrImgSupport[indexPath.row])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {

        return NSLocalizedString("SHOP BY CATEGORIES", comment: "")

        }
        else if section == 1
        {
            return NSLocalizedString("MY ACCOUNT", comment: "")
            
        }
        else{
            return NSLocalizedString("HELP AND SUPPORT", comment: "")
            
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if (section==0){

            return arrCategories.count
            }

        else if(section == 1) {

            return arrAccount.count
        }
        else{
            
            return arrSupport.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.section == 0 {
           // return UITableViewAutomaticDimension
            return 50
        }
        else{
            return 50
           // return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                let dic = CategoryList[0] as! NSDictionary
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                     
                let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC

                categoryVC.title = dic.value(forKey: NSLocalizedString("category_name", comment: "")) as? String
                
                categoryVC.categoryDic = dic

                self.navigationController?.pushViewController(categoryVC, animated: true)
                
            } else if indexPath.row == 1 {
                
                let dic = CategoryList[1] as! NSDictionary
                
                     let storyboard = UIStoryboard(name: "Main", bundle: nil)
                          
                     let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC

                     categoryVC.title = dic.value(forKey: NSLocalizedString("category_name", comment: "")) as? String
                     
                     categoryVC.categoryDic = dic

                     self.navigationController?.pushViewController(categoryVC, animated: true)
                
            } 
            
        } else if indexPath.section == 1 {
            
            if indexPath.row == 1 {
                
                               let LanguageViewController = self.storyboard!.instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageVC
                
                        self.navigationController?.pushViewController(LanguageViewController, animated: true)
            }
            
        } else {
            
        }
        

    }
    
    func setupHeaderView() {

        let options = StretchHeaderOptions()
        options.position = .underNavigationBar

        header = StretchHeader()
        header.stretchHeaderSize(headerSize: CGSize(width: view.frame.size.width, height: 150),
                                 imageSize: CGSize(width: view.frame.size.width, height: 180),
                                 controller: self,
                                 options: options)

        let rectborder = CGRect(x: 15, y: 15, width: 120, height: 120)
        let imageViewBorder = UIImageView(frame:rectborder);
        imageViewBorder.backgroundColor = UIColor.clear
        imageViewBorder.layer.cornerRadius = imageViewBorder.frame.height/2.0
        imageViewBorder.clipsToBounds = true
        imageViewBorder.layer.borderWidth = 1
        imageViewBorder.layer.borderColor = UIColor(red:231/255, green:192/255, blue:31/255, alpha: 1).cgColor
        header.imageView.addSubview(imageViewBorder)


        let rect = CGRect(x: 25, y: 25, width: 100, height: 100)
        let imageViewProfile = UIImageView(frame:rect);
      //  let image = UIImage(named: "user_profile_icon");
        imageViewProfile.backgroundColor = UIColor.clear
        imageViewProfile.layer.cornerRadius = imageViewProfile.frame.height/2.0
        imageViewProfile.clipsToBounds = true
        header.imageView.addSubview(imageViewProfile)


        dicLoginUserData = (UserDefaults.standard.object(forKey: "dictionaryKey") as? NSDictionary)!
        dicUserProfile =  dicLoginUserData .object(forKey: "user") as! NSDictionary
      let  strFirstName =  dicUserProfile["first_name"] as! NSString
      let  strLastName =  dicUserProfile["last_name"] as! NSString
      imageViewProfile.setImage(string: "\(strFirstName) \(strLastName)", color: UIColor.black, circular: true, stroke: true)




        let rectLabel = CGRect(x: imageViewProfile.frame.origin.x + imageViewProfile.frame.size.width+15, y: 10, width: 200, height: 100)
        let lblUserName = UILabel(frame:rectLabel);
        lblUserName.text = (strFirstName as String) + (" " as String) + (strLastName as String)
        lblUserName.font = UIFont.boldSystemFont(ofSize: 20.0)
        lblUserName.textColor = UIColor.black
        lblUserName.backgroundColor = UIColor.clear
        header.imageView.addSubview(lblUserName)


        let rectEmail = CGRect(x: imageViewProfile.frame.origin.x + imageViewProfile.frame.size.width+15, y: 35, width: 200, height: 100)
        let lblEmail = UILabel(frame:rectEmail);
        lblEmail.text =  dicUserProfile["email"] as! NSString as String
        lblEmail.textColor = UIColor.darkGray
        lblEmail.backgroundColor = UIColor.clear
        header.imageView.addSubview(lblEmail)


        let rectImg = CGRect(x: self.view.frame.size.width-35, y: 60, width: 25, height: 25)
        let imageViewArrow = UIImageView(frame:rectImg);
        let imageA = UIImage(named: NSLocalizedString("Arrow", comment: ""));
        imageViewArrow.image = imageA;
        header.imageView.addSubview(imageViewArrow)



        let rectBtn = CGRect(x:25, y: 25, width: self.view.frame.size.width, height: 100)
        let btnProfile = UIButton(frame:rectBtn);
        btnProfile.addTarget(self, action: #selector(profileBtnAction), for: .touchUpInside)
        header.imageView.addSubview(btnProfile)
         header.imageView.contentMode = .scaleAspectFill
         tblSlider.tableHeaderView = header
    }


    @objc func profileBtnAction(){

        let obj = self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileVC
        self.navigationController?.pushViewController(obj, animated: true)
    }
    
    
    func GetCategoryApi()
    {
        DicParameters = [:]
        hud.textLabel.text = NSLocalizedString("Loading",comment: "")
        
        hud.show(in: self.view)
        ApiBaseClass.apiCallingWithGetMethode(url:"http://theblocksapp.com/api/getAllCategories", completion: { [weak self] response in
            let errorCheck = response["success"] as! Bool
            
            if errorCheck
            {
                var dic = NSDictionary()
                dic = response as NSDictionary
                CategoryList = dic["data"] as! NSArray
                
                hud.dismiss()
             //   addPageMenu(count: (CategoryList.count))
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
extension SliderMenuVC {

    func setupNavButtons() {


        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black



        let btnClose = UIBarButtonItem(image: #imageLiteral(resourceName: "close_icon"), style: .plain, target: self, action: #selector(closeAction))

        navigationItem.leftBarButtonItem = btnClose

        let notifiButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "notification_icon_gray"), style: .plain, target: self, action:#selector(notificationAction))

        navigationItem.rightBarButtonItems = [notifiButtonItem]
        navigationController?.navigationBar.setNeedsLayout()

    }

    @objc func backAction(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    @objc func closeAction()
    {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func notificationAction()
        
    {

    }

    @objc func searchAction()
    {

    }
    
}
