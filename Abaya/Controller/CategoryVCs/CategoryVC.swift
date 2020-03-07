//
//  CategoryVC.swift
//  Abaya
//
//  Created by khaled Bohout on 11/7/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import JGProgressHUD
import SDWebImage


class CategoryVC: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var categoryDic = NSDictionary()
    
    var arrSubCategories = NSArray()
    
//    var lblNewBlocks  = UILabel()
//
//    var btnShowAll = UIButton()
    
    var iD = Int()
    
    @IBOutlet weak var bannerHeight: NSLayoutConstraint!
    
    var hud = JGProgressHUD(style: .extraLight)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //backBySwipe()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
                
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "storeCell", bundle: nil), forCellReuseIdentifier: "storeCell")
        

        
        setupNavButtons()
        
        loadProducts()
        
        // Do any additional setup after loading the view.
    }

    
    func loadProducts() {
        
        hud.textLabel.text = NSLocalizedString("loading", comment: "")
        
        hud.show(in: self.view)
        
        
        arrSubCategories = categoryDic .value(forKey: "children") as! NSArray

        
        self.title = (categoryDic.value(forKey: NSLocalizedString("category_name", comment: "")) as! String)
        
        let imgStrUrl = .imagebaseURL + "category/" + (categoryDic.value(forKey: "category_image") as! String)
        
        
        hud.dismiss()
    }
    
    func backBySwipe() {
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        tableView.addGestureRecognizer(gesture)
    }
    

    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {

        self.navigationController?.popViewController(animated: true)
    }

}

extension CategoryVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSubCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath as IndexPath) as! storeCell
        
        let dic = arrSubCategories[indexPath.row] as! NSDictionary
        
        cell.store_name.text = (dic.value(forKey: NSLocalizedString("category_name", comment: "")) as? String)!
               
        cell.store_coutry.text = ""
               
        cell.store_coutry.textColor = UIColor.white
               
        cell.store_name.textColor = UIColor.white
               
        let strurl = .imagebaseURL + "category/" + (dic.value(forKey: "category_image") as! String)
            
        let fileUrl = URL(string: strurl)

        cell.store_imageimage.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: "store_cover_two"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
               })

        cell.selectionStyle = .none
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return self.view.frame.size.width/2.2
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let catDic = arrSubCategories[indexPath.row] as! NSDictionary
        
        iD = catDic .value(forKey: "id") as! Int
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ProductListVC")
        categpryID = String(iD)
        print(categpryID)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}

extension CategoryVC {
    
    func setupNavButtons() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
        let menuButtonItem = UIBarButtonItem(image: UIImage(named: NSLocalizedString("back_arrow", comment: "")), style: .plain, target: self, action: #selector(backAction))
        
        navigationItem.leftBarButtonItem = menuButtonItem
        
        let favButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "shoppingBagIcon"), style: .plain, target: self, action:#selector(openCart))
        let searchButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchIcon"), style: .plain, target: self, action: #selector(searchAction))
        self.navigationController?.navigationBar.tintColor = UIColor.black;

        navigationItem.rightBarButtonItems = [searchButtonItem, favButtonItem]

        navigationController?.navigationBar.setNeedsLayout()
        
    }
    
    @objc func backAction()
    {
        
      navigationController?.popViewController(animated: true)

    }
    
    @objc func openCart()
    {
        let VC = self.storyboard!.instantiateViewController(withIdentifier: "CartVC") as! CartVC
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @objc func searchAction()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


