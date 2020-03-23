//
//  ShopProductDetail.swift
//  PEMS
//
//  Created by Unify Systems on 03/10/18.
//  Copyright © 2018 Unify Systems. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import SDWebImage
import Toast_Swift

class ProductDetail: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UIScrollViewDelegate {

    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var imagesCollectionView: UICollectionView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var lblQuality: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblMaterial: UILabel!
    @IBOutlet weak var lblMenufacturedIn: UILabel!
    @IBOutlet weak var lblProductCount: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var widthLbl: UILabel!
    @IBOutlet weak var widthValueLbl: UILabel!
    @IBOutlet weak var recommendedCollectionView: UICollectionView!
    @IBOutlet weak var sizesCollectionView: UICollectionView!
    
    var count = 1
    var arrSlider = NSArray()
    var arrNewArr = NSArray()
    var relatedArr = NSArray()
    var arrSize = NSArray()
    var arrColor = NSArray()
    var mydic = NSDictionary()
    var hud = JGProgressHUD(style: .extraLight)
    var pageMenu : CAPSPageMenu?
    var sizesArr = NSArray()
    var SKu = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(strProductId)
        
        backBySwipe()
        
        self.widthLbl.text = NSLocalizedString("width", comment: "")
        self.widthValueLbl.text = NSLocalizedString("double width", comment: "")

        self.view.frame =  CGRect(0, 0, self.view.frame.size.width, self.view.frame.size.height+800)
        
        setUpCollectionViews()

        GetProductDetail()
        
        setupNavButtons()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupNavButtons()
    }
    
    func backBySwipe() {
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        self.view.addGestureRecognizer(gesture)
    }
    
    

    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {

        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpCollectionViews() {
        
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.isPagingEnabled = true
        imagesCollectionView.register(UINib.init(nibName: "HomeSliderCell", bundle: nil), forCellWithReuseIdentifier: "HomeSliderCell")
        
        imagesCollectionView.showsVerticalScrollIndicator = false
        imagesCollectionView.backgroundColor = UIColor.white
        
        let Rlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        Rlayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        Rlayout.scrollDirection = .horizontal
        Rlayout.minimumInteritemSpacing = 10
        Rlayout.minimumLineSpacing = 10
        
        
        sizesCollectionView.dataSource = self
        sizesCollectionView.delegate = self
        sizesCollectionView.isPagingEnabled = true
        sizesCollectionView.register(UINib.init(nibName: "ProductSizeCell", bundle: nil), forCellWithReuseIdentifier: "ProductSizeCell")
        
        sizesCollectionView.showsVerticalScrollIndicator = false
        sizesCollectionView.backgroundColor = UIColor.white
        



    
        recommendedCollectionView.collectionViewLayout = Rlayout
        recommendedCollectionView.dataSource = self
        recommendedCollectionView.delegate = self
        recommendedCollectionView.isPagingEnabled = true
        recommendedCollectionView.register(UINib.init(nibName: "subcat2CollectionCell", bundle: nil), forCellWithReuseIdentifier: "subcat2CollectionCell")
        recommendedCollectionView.showsVerticalScrollIndicator = false
        recommendedCollectionView.backgroundColor = UIColor.white
    }
    

    @IBAction func AddToBagTapped(_ sender: Any) {
        
        let signed = getUserDetails()
        
        if signed {
            
            self.addToCart()
            
        } else {
            
            Alert.showSignUpAlert(viewcontroller: self)
        }
    }
    
    override func viewDidLayoutSubviews()
        
    {
        
        scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+800)

        
    }
            
    func GetWishList()
    {
        let signed = getUserDetails()
        
        if signed {

        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getWishlist(), completion: { [weak self] response in
            let errorCheck = response["success"] as! Bool
            
            if errorCheck
            {
                
                var dic = NSDictionary()
                dic = response as NSDictionary
                let arrWishlist = dic["data"] as! NSArray
                
                print(arrWishlist)
                
                for i in arrWishlist {
                    

                    
                    let id = String((i as! NSDictionary) .value(forKey: "product_id") as! Int )
                    print(id)
                    print(strProductId)
                    if id == strProductId {
                        self?.favButton.setImage(UIImage(named: "wishlist_heart_filled"), for: .normal)
                    }
                }
            }
            else
            {
                self!.hud.dismiss()
                     Alert.Show(title:NSLocalizedString("something wrong", comment: ""), mesage: NSLocalizedString("Please try again.", comment: ""), viewcontroller:self!)
                      
                  }
                  }, failure: { [weak self] failResponse in
                    self!.hud.dismiss()
                      Alert.Show(title: NSLocalizedString("network error", comment: ""), mesage:NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
        })
        } else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count : Int?
        
        if collectionView == imagesCollectionView {
        
        count = arrSlider.count
            
        } else if collectionView == recommendedCollectionView {
            
        count =  relatedArr.count
            
        } else if collectionView == sizesCollectionView {
            
            count = sizesArr.count
        }
        
        return count!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                 sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size : CGSize?
        
        if collectionView == imagesCollectionView {
        
        size =  CGSize(width: (self.imagesCollectionView.frame.width), height: (self.imagesCollectionView.frame.height
        ))
        } else if collectionView == recommendedCollectionView {
            
        size =  CGSize(width: (self.recommendedCollectionView.frame.width/3), height: (self.recommendedCollectionView.frame.height))
            
        } else if collectionView == sizesCollectionView {
            
            size = CGSize(width: 60.0, height: 45.0)
            
        }
        return size!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var myCell : UICollectionViewCell?
        
        if collectionView == imagesCollectionView {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeSliderCell", for: indexPath) as! HomeSliderCell
        
        var dic = NSDictionary()
        dic = arrSlider[indexPath.row] as! NSDictionary
        
       // let strimgUrl = .imagebaseURL + "banners/" + (dic.value(forKey: "image") as? String)!
         let strimgUrl = .imagebaseURL + "products/" + (dic.value(forKey: "image") as? String)!
            print(strimgUrl)
        let fileUrl = NSURL(string: strimgUrl)
        
        cell.imgSlider.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: "store_cover_two"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
            myCell = cell
            
        } else if collectionView == recommendedCollectionView {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subcat2CollectionCell", for: indexPath) as! subcat2CollectionCell
                        
        var dic = NSDictionary()
                        
        dic = relatedArr[indexPath.row] as! NSDictionary
                        
        cell.lblName.text = (dic.value(forKey: "product_name") as? String)!
             
        cell.lblBrand.text = (dic.value(forKey: "brand") as? String)!
                        
        let strimgUrl = .imagebaseURL + "products/" + (dic.value(forKey: "product_image") as? String)!
        let fileUrl = NSURL(string: strimgUrl)
                        
        cell.img.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                        })
            myCell =  cell
            
        } else if collectionView == sizesCollectionView  {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductSizeCell", for: indexPath) as! ProductSizeCell
            print(sizesArr)
            let size = sizesArr[indexPath.row] as! NSDictionary
            let sizeValue = (size .value(forKey: "attribute_option") as? String)!
            cell.sizeBtn.setTitle(sizeValue, for: .normal)
            cell.sizeBtn.tag = indexPath.row
            cell.sizeBtn.addTarget(self, action: #selector(buttonSize), for: .touchUpInside)
            let skuarr = size .value(forKey: "sku") as! NSArray
            if skuarr[0] as? Int == Int(SKu) {
               cell.sizeBtn.backgroundColor = UIColor.black
               cell.sizeBtn.setTitleColor(UIColor.white, for: .normal)
                
            } else {
                
                cell.sizeBtn.backgroundColor = UIColor.white
                cell.sizeBtn.setTitleColor(UIColor.black, for: .normal)
            }
            myCell =  cell
        }
        
        return myCell!

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == recommendedCollectionView {
            
            print("selected")
            
            let dic = relatedArr[indexPath.row] as! NSDictionary
            
            print(dic)
            
            let x : Int = dic.value(forKey: "product_id") as! NSInteger
            
            print(x)
            
            strProductId = String(x)
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let productCV = storyboard.instantiateViewController(withIdentifier: "productVC") as! ProductDetail
            
            self.navigationController?.pushViewController(productCV, animated: true)
            
        } else if collectionView == imagesCollectionView {
            
             let dic = arrSlider[indexPath.row] as! NSDictionary
             
            // let strimgUrl = .imagebaseURL + "banners/" + (dic.value(forKey: "image") as? String)!
            let imagePath =  (dic.value(forKey: "image") as? String)!
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let productImageVC = storyboard.instantiateViewController(withIdentifier: "ProductImageVC") as! ProductImageVC
            
            productImageVC.imagePath = imagePath
            
            self.navigationController?.pushViewController(productImageVC, animated: true)
            
        }  else if collectionView == sizesCollectionView {
            
            print("selected")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        pageControl.currentPage = Int(indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
//    func startTimer() {
//
//        _ =  Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
//    }
//
//
//    @objc func scrollAutomatically(_ timer1: Timer) {
//
//        if let coll  = imagesCollectionView {
//            for cell in coll.visibleCells {
//                let indexPath: IndexPath? = coll.indexPath(for: cell)
//                if ((indexPath?.row)! < arrSlider.count - 1){
//                    let indexPath1: IndexPath?
//                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
//
//                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
//                }
//                else{
//                    let indexPath1: IndexPath?
//                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
//                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
//                }
//
//            }
//        }
//    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
    }
    
    @IBAction func favButtonTapped(_ sender: Any) {
        
        let signed = getUserDetails()
        
        if signed {
        
        if favButton.image(for: .normal) == UIImage(named: "wishlist_heart_filled") {
            
            deleteFromWishList()
            
        } else {
        
        addToWishList()
            
        }
        } else {
            Alert.showSignUpAlert(viewcontroller: self)
        }
        
    }
    
    func addToCart() {
        
        hud.show(in: self.view)
        
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
        
        let quantity = lblProductCount.text!
        
        
        
        let par = ["product_id" : priduct_id,
                   "qty" : quantity,
                   "sku_id" : SKu]

        ApiBaseClass.apiCallingMethode(url: ApiBaseClass.addtocartapi(), parameter: par, completion: { (response) in
            self.hud.dismiss()
            Alert.ShowAction(title: NSLocalizedString("Item Added", comment: "") , mesage: NSLocalizedString("Item Added To Cart Successfully", comment: "") , viewcontroller: self)
            
        }) { (error) in
            
            print("khaled error sending item to cart \(error)")
        }
        
    }

    
    func GetProductDetail()
    {
        DicParameters = [:]
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)
        
        ApiBaseClass.apiCallingWithGetProMethode(url:ApiBaseClass.getShopProductDetail(), completion: { [weak self] response in
            
          //  print("khaled basha \(ApiBaseClass.getShopProductDetail())")
            
            var dic = NSDictionary()
            
            dic = response["data"] as! NSDictionary
            print( "\(dic)")
            
            self?.mydic = dic
            let attribute_group = dic.value(forKey: "attribute_group") as! NSDictionary
            let attributes = attribute_group.value(forKey: "attributes") as! NSArray
            let attribute_options = attributes.value(forKey: "attribute_options") as! NSArray
            let sizesByMetre = attribute_options[0] as! NSArray
            self?.sizesArr = sizesByMetre
            self?.sizesCollectionView.reloadData()
            self?.arrSlider = dic["products_images"] as! NSArray
            print(self!.arrSlider.count)
            self?.imagesCollectionView.reloadData()
            self?.pageControl.numberOfPages = (self?.arrSlider.count)!
            //self!.startTimer()
            self?.lblProductName.text = dic.object(forKey: "product_name") as? String
            let strPrice = String(format: "%@%@","KD ", dic.value(forKey: "product_current_price") as! CVarArg)
            self?.lblProductPrice.text = strPrice as String
            self?.lblDescription.text = dic.object(forKey: "product_description") as? String
            self?.lblBrandName.text = dic.object(forKey: "brand") as? String
            self?.lblMenufacturedIn.text = dic.object(forKey: "made_in_country") as? String
            self?.lblWeight.text = dic.object(forKey: "weight") as? String
            self?.lblMaterial.text = dic.object(forKey: "material") as? String
            //self?.widthValueLbl.text = "\((dic.object(forKey: "width") as! Int) * 2 )"
            strProductId = String(dic .value(forKey: "id") as! Int)
            
            self!.GetWishList()
            print(strProductId)
            self!.GetRelatedProducts()
            
            self?.hud.dismiss()
            
            }, failure: { [weak self] failResponse in
                self?.hud.dismiss()
                Alert.Show(title: NSLocalizedString("network error", comment: "") , mesage: NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
        })
    }
    
    func GetRelatedProducts()
    {

        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        
        hud.show(in: self.view)
        

      
       
        ApiBaseClass.apiCallingWithGetProMethode(url:ApiBaseClass.recommendedProducts(), completion: { [weak self] response in
            
            let errorCheck = response["success"] as! Bool
            
            var dic = NSDictionary()
            
            dic = response as NSDictionary
            
            if errorCheck
            {
                var dicData = NSArray()
                
                dicData = dic["data"]  as! NSArray
                
                print(dicData)
                
                
                self?.relatedArr  = dicData

                self?.recommendedCollectionView.reloadData()
                
                 self?.hud.dismiss()
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

    
    
    //slider
    func GetNewBlock()
    {
        
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.newStoresonBlocks(), completion: { [weak self] response in
            let errorCheck = response["success"] as! Bool
            var dic = NSDictionary()
            dic = response as NSDictionary
            if errorCheck
            {
                self?.arrSlider = dic["data"] as! NSArray
                self?.imagesCollectionView.reloadData()
                self?.pageControl.numberOfPages = (self?.arrSlider.count)!
               // self?.GetCategoryApi()
                
            }
            else
            {
                
                      Alert.Show(title:NSLocalizedString("something wrong", comment: ""), mesage: NSLocalizedString("Please try again.", comment: ""), viewcontroller:self!)
                        
                    }
                    }, failure: { [weak self] failResponse in
                        self?.hud.dismiss()
                        Alert.Show(title: NSLocalizedString("network error", comment: ""), mesage:NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)        })
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
                self?.hud.dismiss()
       //         let message = dic .value(forKey: "message") as! String
                
                self?.favButton.setImage(UIImage(named: "wishlist_heart_filled"), for: .normal)
                
                self!.view.makeToast(NSLocalizedString("Item Added To Wishlist", comment: ""), duration: 2.0, position: .center)
                
               

                    
            }

                    }, failure: { [weak self] failResponse in
                        self?.hud.dismiss()
                        Alert.Show(title: NSLocalizedString("network error", comment: "") , mesage: NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
                })
            }
    
    func deleteFromWishList() {
        
          DicParameters = [:]
          hud.textLabel.text = NSLocalizedString("Loading", comment: "")
          hud.show(in: self.view)
          ApiBaseClass.apiCallingWithDeleteMethode(url:ApiBaseClass.deletefromWishList(), completion: { [weak self] response in
              
              
              print("khaled: \(response)")
            
            self?.favButton.setImage(UIImage(named: "wishlist_icon_gray copy"), for: .normal)

            self!.hud.dismiss()
              

              }, failure: { [weak self] failResponse in
                self!.hud.dismiss()
                  Alert.Show(title:"", mesage:.no_internet, viewcontroller:self!)
          })
    }
    
    @objc func buttonSize(sender: UIButton){
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to: self.sizesCollectionView)
        let indexPath = self.sizesCollectionView.indexPathForItem(at: buttonPosition)
        let sizeDic = self.sizesArr[(indexPath?.row)!] as! NSDictionary
        let skuArr = sizeDic .value(forKey:  "sku") as! NSArray
        let sku = skuArr[0] as! Int
        SKu = String(sku)
        sizesCollectionView.reloadData()
        
    }
    
    @IBAction func incresecount(_ sender: Any) {
        
        
        count += 1

        lblProductCount.text = String(count)
    }
    
    @IBAction func decreeseCount(_ sender: Any) {
        
        count -= 1

        lblProductCount.text = String(count)
    }
    
    
    
}

// MARK:- Navigation
extension ProductDetail {
    
    func setupNavButtons() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.title = NSLocalizedString("Product Detail", comment: "") 
        
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

