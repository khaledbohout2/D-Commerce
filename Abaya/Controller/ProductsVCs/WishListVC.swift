//
//  WishListVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/22/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.

import UIKit
import SDWebImage

class WishListVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var wishCollcationView: UICollectionView!
    
    let obj = WishListModelClass()
    var arrWishlist = NSArray()
    var mydic = NSDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupNavButtons()
        
        wishCollcationView.register(UINib(nibName: "WishListCell", bundle: nil), forCellWithReuseIdentifier: "WishListCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
}
    // MARK:- Navigation
    extension WishListVC {
        
        func setupNavButtons() {
            
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = false
            self.navigationController?.view.backgroundColor = UIColor.lightGray
            self.navigationController?.navigationBar.tintColor = UIColor.black
            title = NSLocalizedString("WishList", comment: "")
            
            let backButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backAction))
            navigationItem.leftBarButtonItem = backButtonItem
            navigationController?.navigationBar.setNeedsLayout()
            GetWishList()
        }
        
        @objc func backAction(sender: UIBarButtonItem) {
            navigationController?.popViewController(animated: true)
        }
        
        func GetWishList()
        {
            DicParameters = [:]
            hud.textLabel.text = NSLocalizedString("Loading", comment: "")
            hud.show(in: self.view)
            ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getWishlist(), completion: { [weak self] response in
                let errorCheck = response["success"] as! Bool
                
                if errorCheck
                {
                    
                    var dic = NSDictionary()
                    dic = response as NSDictionary
                    self?.arrWishlist = dic["data"] as! NSArray
                  //  print(self?.arrWishlist)
                    self?.wishCollcationView.reloadData()
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
        
        
        
//        func addToCartApi()
//        {
//
//            hud.textLabel.text = "Loading"
//            hud.show(in: self.view)
//
//            DicParameters = ["product_id":strAddToCartProductId, "qty":strQty, "sku_id":strSkuId] as [String : Any] as! [String : String]
//
//            ApiBaseClass.apiCallingMethode(url:ApiBaseClass.addtocartapi(), parameter:DicParameters , completion: { [weak self] response in
//                let errorCheck = response["success"] as! Bool
//
//                var dic = NSDictionary()
//                dic = response as NSDictionary
//                if errorCheck
//                {
//                    hud.dismiss()
//
//
//                    Alert.Show(title:"", mesage: "Product add to cart successfully.", viewcontroller:self!)
//                    self!.GetWishList()
//
//                }
//                else
//                {
//                    hud.dismiss()
//                    Alert.Show(title:"", mesage:dic.object(forKey: "message") as! String, viewcontroller:self!)
//
//                }
//                }, failure: { [weak self] failResponse in
//                    hud.dismiss()
//                    Alert.Show(title:"network error", mesage:"Please try again.", viewcontroller:self!)
//            })
//        }
        
        func addToCart() {
            
            var SKu = String()
            
            let priduct_id = strProductId as String
            
            let producttype = mydic.value(forKey: "product_type") as! String
            
            if producttype == "Configurable Product" {
                
                let attribute_group = mydic.value(forKey: "attribute_group") as! NSDictionary
                let attributes = attribute_group.value(forKey: "attributes") as! NSArray
                let attribute_options = attributes.value(forKey: "attribute_options") as! NSArray
                let arr = attribute_options[0] as! NSArray
                let first = arr[0] as! NSDictionary
                let SKUS = first.value(forKey: "sku") as! NSArray
                let firstsku = SKUS[0] as! Int
                SKu = String(firstsku)
                
            }
                
            else {
                
                SKu = priduct_id
            }
            
            let quantity = String(1)
            
            
            
            let par = ["product_id" : priduct_id,
                       "qty" : quantity,
                       "sku_id" : SKu]

            ApiBaseClass.apiCallingMethode(url: ApiBaseClass.addtocartapi(), parameter: par, completion: { (response) in
                
                self.deleteFromWishList()
                
                Alert.ShowAction(title: NSLocalizedString("Item Added To Cart", comment: "") , mesage: "", viewcontroller: self)

                
            }) { (error) in
                
                print("khaled error sending item to cart \(error)")
            }
            
        }
        
        func deleteFromWishList() {
            
              DicParameters = [:]
              hud.textLabel.text = NSLocalizedString("Loading", comment: "")
              hud.show(in: self.view)
              ApiBaseClass.apiCallingWithDeleteMethode(url:ApiBaseClass.deletefromWishList(), completion: { [weak self] response in
                  
                  
                  print("khaled: \(response)")

                      hud.dismiss()
                  
                      self!.GetWishList()

                      self!.wishCollcationView.reloadData()
                  

                  }, failure: { [weak self] failResponse in
                      hud.dismiss()
                      Alert.Show(title:"", mesage:.no_internet, viewcontroller:self!)
              })
        }

        
}

extension WishListVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrWishlist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCell", for: indexPath) as! WishListCell
        
        var dic = NSDictionary()
        
        dic = arrWishlist[indexPath.row] as! NSDictionary
      //  print(dic)
        
        let strimgUrl = .imagebaseURL + "products/" + (dic.value(forKey: "product_image") as? String)!
        let fileUrl = NSURL(string: strimgUrl)
        
        cell.image_view.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        
        cell.lblName.text = dic .object(forKey: "brand") as?String
        cell.lbldetail.text = dic .object(forKey: "product_name") as?String
        
        let x : Int = (dic .object(forKey: "product_current_price") as? NSInteger)!
        let stringValue = "\(x)"
        print(stringValue)
        
        cell.lblPrice.text = "KD " + stringValue
        
        
        cell.btnAddToBag.tag = indexPath.row
        cell.btnAddToBag.addTarget(self, action: #selector(buttonAddToBagAction), for: .touchUpInside)
        cell.btnWish.addTarget(self, action: #selector(buttonDeleteFromCart(sender:)), for: .touchUpInside)


        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (wishCollcationView.frame.width/2.1), height:331)
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        

    }
    
    func GetProductDetail()
    {
        DicParameters = [:]
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)
        
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getShopProductDetail(), completion: { [weak self] response in
            
            print("khaled basha \(ApiBaseClass.getShopProductDetail())")
            
            var dic = NSDictionary()
            
            dic = response["data"] as! NSDictionary
          //  print("khaled \(dic)")
            
            self?.mydic = dic
            self?.addToCart()
            

            hud.dismiss()
            
            }, failure: { [weak self] failResponse in
                hud.dismiss()
                        Alert.Show(title: NSLocalizedString("network error", comment: "") , mesage: NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
        })
    }
    @objc func buttonAddToBagAction(sender: UIButton){
        
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.wishCollcationView)
        let indexPath = self.wishCollcationView.indexPathForItem(at: buttonPosition)
        var dicuserDetail = NSDictionary()
        dicuserDetail = self.arrWishlist[(indexPath?.row)!] as! NSDictionary
         print(dicuserDetail)
        
        strProductId = String(dicuserDetail .value(forKey: "id") as! Int )
        print(strProductId)
        
        GetProductDetail()
//        strQty = String(format: "%@",dicuserDetail.value(forKey: "minimum_quantity") as! CVarArg) as NSString
//        strSkuId = String(format: "%@",dicuserDetail.value(forKey: "product_code") as! CVarArg) as NSString
 
    }
    
        @objc func buttonDeleteFromCart(sender: UIButton){
            
            
            let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.wishCollcationView)
            let indexPath = self.wishCollcationView.indexPathForItem(at: buttonPosition)
            var dicuserDetail = NSDictionary()
            dicuserDetail = self.arrWishlist[(indexPath?.row)!] as! NSDictionary
             print(dicuserDetail)
            
            strProductId = String(dicuserDetail .value(forKey: "id") as! Int )
            print(strProductId)
            
            deleteFromWishList()
            
            Alert.Show(title: NSLocalizedString("Item Deleted", comment: ""), mesage: NSLocalizedString("Item Deleted From WishList", comment: ""), viewcontroller: self)
            
           // GetProductDetail()
    //        strQty = String(format: "%@",dicuserDetail.value(forKey: "minimum_quantity") as! CVarArg) as NSString
    //        strSkuId = String(format: "%@",dicuserDetail.value(forKey: "product_code") as! CVarArg) as NSString
     
        }

 
}
