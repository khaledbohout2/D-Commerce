//
//  ProductListVC.swift
//  Abaya
//
//  Created by Chandar on 07/04/19.
//  Copyright © 2019 Kareem Mohammed. All rights reserved.
//

import UIKit
import SDWebImage

class ProductListVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ProductsCollectionView: UICollectionView!
    
    let obj = WishListModelClass()
    var productsListArr = [NSDictionary]()
    var pagenum = Int()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupNavButtons()
        
        ProductsCollectionView.register(UINib(nibName: "ProductListCell", bundle: nil), forCellWithReuseIdentifier: "ProductListCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    
          func getPageNumber() {
           
    
               
               DicParameters = [:]
               hud.textLabel.text = NSLocalizedString("Loading", comment: "")
               hud.show(in: self.view)
               ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getProductList(), completion: { [weak self] response in
                   let errorCheck = response["success"] as! Bool
                   
                   if errorCheck
                   {
                       
                   var dic = NSDictionary()
                   dic = response as NSDictionary
           
                       
                   var dictemp = NSDictionary()
                   dictemp = dic["data"] as! NSDictionary
                   self!.pagenum = dictemp .value(forKey: "last_page") as! Int
                       self?.GetProductsList()
                       
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
           
           func GetProductsList()
           {
               for n in 1...pagenum {
                  let page = n
                   
                   DicParameters = ["page": String(page)]
                   hud.textLabel.text = NSLocalizedString("Loading", comment: "")
                   hud.show(in: self.view)
                   ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getProductList(), completion: { [weak self] response in
                       let errorCheck = response["success"] as! Bool
                       
                       if errorCheck
                       {
                           
                           var dic = NSDictionary()
                           dic = response as NSDictionary
                         //  print(dic)
                           
                           var dictemp = NSDictionary()
                           dictemp = dic["data"] as! NSDictionary
                           let arr = dictemp["data"] as! [NSDictionary]
                           self?.productsListArr.append(contentsOf: arr)
                          // self?.productsListArr = dictemp["data"] as! NSArray
                          // print(self?.arrWishlist as Any)
                           self?.ProductsCollectionView.reloadData()
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

}
    // MARK:- Navigation
    extension ProductListVC {
        
        func setupNavButtons() {
            
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.view.backgroundColor = UIColor.lightGray
            self.navigationController?.navigationBar.tintColor = UIColor.black
            self.title = NSLocalizedString("New On Blocks", comment: "")
            getPageNumber()
            
            let menuButtonItem = UIBarButtonItem(image: UIImage(named: "back_arrow"), style: .plain, target: self, action: #selector(backAction))
            
            navigationItem.leftBarButtonItem = menuButtonItem
            
            let favButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "shoppingBagIcon"), style: .plain, target: self, action:#selector(openCart))
            let searchButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchIcon"), style: .plain, target: self, action: #selector(searchAction))
            self.navigationController?.navigationBar.tintColor = UIColor.black;

            navigationItem.rightBarButtonItems = [searchButtonItem, favButtonItem]

            navigationController?.navigationBar.setNeedsLayout()
            
        }
        
        @objc func backAction(sender: UIBarButtonItem) {
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

extension ProductListVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsListArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductListCell", for: indexPath) as! ProductListCell
        
        var dic = NSDictionary()
        
        dic = productsListArr[indexPath.row]
       // print(dic)
        
       // let dicProduct = dic.object(forKey: "product_image") as! NSDictionary
        
        let strimgUrl = .imagebaseURL + "products/" + (dic.value(forKey: "product_image") as? String)!
        let fileUrl = NSURL(string: strimgUrl)
        
        cell.image_view.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        
        
        cell.lblName.text = dic .object(forKey: "brand") as?String
        cell.lbldetail.text = dic .object(forKey: "product_name") as?String
        
        let x : Double = (dic .object(forKey: "product_current_price") as? Double)!
        let stringValue = "\(x)"
      //  print(stringValue)
        
        cell.lblPrice.text = "KD " + stringValue


        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (ProductsCollectionView.frame.width/2.1), height:285)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var dicDetail = NSDictionary()
        dicDetail = productsListArr[indexPath.row]
        
        
        let x : Int = dicDetail.value(forKey: "product_id") as! NSInteger
        strProductId = String(x) 
        
//strShopProductId = "1"
        
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "productVC") as! ProductDetail
              self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}
