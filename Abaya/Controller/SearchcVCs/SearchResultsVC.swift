//
//  SearchResultsVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/26/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import SDWebImage

class SearchResultsVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UITableViewDelegate {

    var productArr = NSArray()
    var mydic = NSDictionary()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "WishListCell", bundle: nil), forCellWithReuseIdentifier: "WishListCell")

        filterProducts()

        // Do any additional setup after loading the view.
    }
    
    func filterProducts() {
        
        DicParameters = ["keyword" : productToFilter, "orderByPrice" : "orderByPrice", "orderByNew" : orderByNew, "minPrice" : minPrice, "maxPrice": maxPrice]
        
        hud.textLabel.text = "Loading"
        
        hud.show(in: self.view)
        
        ApiBaseClass.apiCallingMethode(url:ApiBaseClass.filterProduct(), parameter: DicParameters, completion: { [weak self] response in
            
                            let errorCheck = response["success"] as! Bool
                
                            if errorCheck
                              
                            {
                                
                              hud.dismiss()
                              let dic = response as NSDictionary
                              let dic2 = dic .value(forKey: "data") as! NSDictionary
                              let arr = dic2 .value(forKey: "data") as! NSArray
                              self!.productArr = arr
                              self!.collectionView.reloadData()
        
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WishListCell", for: indexPath) as! WishListCell
        
        var dic = NSDictionary()
        
        dic = productArr[indexPath.row] as! NSDictionary
        
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
        cell.btnWish.tag = indexPath.row
        cell.btnWish.addTarget(self, action: #selector(buttonAddToWishListAction), for: .touchUpInside)


        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.frame.width/2.1), height:331)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
                let dic = productArr[indexPath.row] as! NSDictionary
        
        let x : Int = dic.value(forKey: "product_id") as! NSInteger
        
        
        
        strProductId = String(x)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let productCV = storyboard.instantiateViewController(withIdentifier: "productVC") as! ProductDetail
        
        self.navigationController?.pushViewController(productCV, animated: true)
    }
    
    @objc func buttonAddToWishListAction(sender: UIButton) {
        
        let signed = getUserDetails()
        
        if signed {
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: buttonPosition)
        var dicuserDetail = NSDictionary()
        dicuserDetail = self.productArr[(indexPath?.row)!] as! NSDictionary
         print(dicuserDetail)
        strProductId = String(dicuserDetail .value(forKey: "product_id") as! Int)
        
        if sender.image(for: .normal) == UIImage(named: "wishlist_icon_gray copy") {
        
        addToWishList()
        
        sender.setImage(UIImage(named: "wishlist_heart_filled"), for: .normal)
            
        } else {
            
            deleteFromWishList()
            
            sender.setImage(UIImage(named: "wishlist_icon_gray copy"), for: .normal)
        }
        } else {
            
            Alert.showSignUpAlert(viewcontroller: self)
        }
        
        
    }
    
        @objc func buttonAddToBagAction(sender: UIButton){
            
            
            let signed = getUserDetails()
            
            if signed {
            
            
            let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.collectionView)
            let indexPath = self.collectionView.indexPathForItem(at: buttonPosition)
            var dicuserDetail = NSDictionary()
            dicuserDetail = self.productArr[(indexPath?.row)!] as! NSDictionary
             print(dicuserDetail)
            
            strProductId = String(dicuserDetail .value(forKey: "product_id") as! Int )
            print(strProductId)
            
            GetProductDetail()
                
            } else {
                Alert.showSignUpAlert(viewcontroller: self)
                
            }
    //        strQty = String(format: "%@",dicuserDetail.value(forKey: "minimum_quantity") as! CVarArg) as NSString
    //        strSkuId = String(format: "%@",dicuserDetail.value(forKey: "product_code") as! CVarArg) as NSString
           
            
        }
    
    func addToWishList() {
        
                DicParameters = ["product_id": String(strProductId) ]
                hud.textLabel.text = "Loading"
                hud.show(in: self.view)

        ApiBaseClass.apiCallingMethode(url:ApiBaseClass.addToWishList(), parameter: DicParameters, completion: { [weak self] response in
                    
            let errorCheck = response["success"] as! Bool
            var dic = NSDictionary()
            dic = response as NSDictionary
            print(dic)
            if errorCheck
            {
                hud.dismiss()
       //         let message = dic .value(forKey: "message") as! String
                
                self!.view.makeToast(NSLocalizedString("Item Added To Wishlist", comment: ""), duration: 2.0, position: .center)
                
               

                    
            }

                    }, failure: { [weak self] failResponse in
                        hud.dismiss()
                        Alert.Show(title: NSLocalizedString("network error", comment: "") , mesage: NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
                })
            }
    
    func deleteFromWishList() {
        
          DicParameters = [:]
          hud.textLabel.text = NSLocalizedString("Loading", comment: "")
          hud.show(in: self.view)
          ApiBaseClass.apiCallingWithDeleteMethode(url:ApiBaseClass.deletefromWishList(), completion: { response in
              
              
              print("khaled: \(response)")

           hud.dismiss()

              }, failure: { [weak self] failResponse in
                hud.dismiss()
                  Alert.Show(title:"", mesage:.no_internet, viewcontroller:self!)
          })
    }
    
    func GetProductDetail()
    {
        DicParameters = [:]
        hud.textLabel.text = "Loading"
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
                Alert.Show(title:"network error", mesage:"Please try again.", viewcontroller:self!)
        })
    }

    
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
            
           // self.deleteFromWishList()

            
        }) { (error) in
            
            print("khaled error sending item to cart \(error)")
        }
        
    }
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        productToFilter = searchBar.text!
            print(productToFilter)
            filterProducts()
            self.collectionView.reloadData()
        

    }
    
    @IBAction func filterButton(_ sender: Any) {
        
    }
    
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        
    }
    



}
