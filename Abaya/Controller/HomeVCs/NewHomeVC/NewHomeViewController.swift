//
//  NewHomeViewController.swift
//  Blocks
//
//  Created by Kareem Mohammed on 1/26/20.
//  Copyright © 2020 Khaled Bohout. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import SDWebImage

class NewHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var hud = JGProgressHUD(style: .extraLight)


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "storeCell", bundle: nil), forCellReuseIdentifier: "storeCell")
        self.GetCategoryApi()
    }


    // MARK:- API
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
                
                self?.hud.dismiss()
//                self?.addPageMenu(count: (CategoryList.count))
                self?.tableView.reloadData()
            }
            else
            {
                self?.hud.dismiss()
                Alert.Show(title:NSLocalizedString("something wrong", comment: ""), mesage: NSLocalizedString("Please try again.", comment: ""), viewcontroller:self!)
                
            }
            }, failure: { [weak self] failResponse in
                self?.hud.dismiss()
                Alert.Show(title: NSLocalizedString("network error", comment: ""), mesage:NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
        })
    }
    
    // MARK:- TableView Datasource and Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        CategoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath as IndexPath) as! storeCell
        var dic = NSDictionary()
        
        dic = CategoryList[indexPath.row] as! NSDictionary
       // print(dic)
        cell.store_name.text = (dic.value(forKey: NSLocalizedString("category_name", comment: "")) as? String)!
        cell.store_coutry.text = "Slogan"
        cell.store_coutry.textColor = UIColor.white
        cell.store_name.textColor = UIColor.white
        
        let strurl = .imagebaseURL + "category/" + (dic.value(forKey: "category_image") as! String)
        let fileUrl = URL(string: strurl)

        cell.store_imageimage.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.width/2.2
    }
}
