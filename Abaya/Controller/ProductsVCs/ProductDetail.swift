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

    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet var lblBrowseShops: UILabel!
    @IBOutlet var scrollMain: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var imagesCollectionView: UICollectionView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblProductPrice: UILabel!
    @IBOutlet weak var lblReviews: UILabel!
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
    
    var count = 1
    
    

    var arrSlider = NSArray()
    var arrNewArr = NSArray()
    var relatedArr = NSArray()
    
    var arrSize = NSArray()
    var arrColor = NSArray()
    var mydic = NSDictionary()
    
    var hud = JGProgressHUD(style: .extraLight)
    var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.widthLbl.text = NSLocalizedString("width", comment: "")
        self.widthValueLbl.text = NSLocalizedString("double width", comment: "")

          self.view.frame =  CGRect(0, 0, self.view.frame.size.width, self.view.frame.size.height+1500)

        imagesCollectionView.dataSource = self

        imagesCollectionView.delegate = self
        
        imagesCollectionView.isPagingEnabled = true
        
        imagesCollectionView.register(UINib.init(nibName: "HomeSliderCell", bundle: nil), forCellWithReuseIdentifier: "HomeSliderCell")
        
        recommendedCollectionView.delegate = self

        recommendedCollectionView.dataSource = self

        recommendedCollectionView.isPagingEnabled = true

        recommendedCollectionView.register(UINib.init(nibName: "subcat2CollectionCell", bundle: nil), forCellWithReuseIdentifier: "subcat2CollectionCell")
        
         let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
         
         //layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
         layout.scrollDirection = .horizontal
         
         layout.minimumInteritemSpacing = 10
        
         layout.minimumLineSpacing = 10
         
         imagesCollectionView.showsVerticalScrollIndicator = false
         
         imagesCollectionView.backgroundColor = UIColor.white
        
       // self.GetNewBlock()
        GetProductDetail()
        
        setupNavButtons()
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setupNavButtons()
    }
    

    @IBAction func AddToBagTapped(_ sender: Any) {
        
        self.addToCart()
        
        
        
        
//                let VC = self.storyboard!.instantiateViewController(withIdentifier: "CartVC") as! CartVC
//                self.navigationController?.pushViewController(VC, animated: true)
    }
    
    override func viewDidLayoutSubviews()
    {
        
        scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+600)

//        self.view.frame = (frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height+600))
        
    }
            
//    @IBAction func plusButtonClicked(_ sender: Any) {
//
//        print("ckidked")
//    }
//    @objc func btnbackaction()
//    {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    @IBAction func addToCartBtnTapped(_ sender: Any) {
//
//        print("khaled add to cart pressed")
//    }
//
//    @IBAction func addButtonTapped(_ sender: Any) {
//    }
//    @IBAction func btnPlusClicked(_ sender: Any) {
//    }
//    @IBAction func addButtonClicked(_ sender: Any) {
//
//
//        print("ckidked")
//    }
//
//    @IBAction func btnAddToBagClicked(_ sender: Any) {
//
//        let VC = self.storyboard!.instantiateViewController(withIdentifier: "CartVC") as! CartVC
//        self.navigationController?.pushViewController(VC, animated: true)
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var count : Int?
        
        if collectionView == imagesCollectionView {
        
        count = arrSlider.count
            
        } else if collectionView == recommendedCollectionView {
            
        count =  relatedArr.count
            
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
        } else {
        size =  CGSize(width: (self.imagesCollectionView.frame.width/3), height: (self.imagesCollectionView.frame.height
        ))
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
        let fileUrl = NSURL(string: strimgUrl)
        
        cell.imgSlider.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
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
        }
        
        return myCell!

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if collectionView == recommendedCollectionView {
            
            let dic = relatedArr[indexPath.row] as! NSDictionary
            
            let x : Int = dic.value(forKey: "product_id") as! NSInteger
            
            strProductId = String(x)
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let productCV = storyboard.instantiateViewController(withIdentifier: "productVC") as! ProductDetail
            
            self.navigationController?.pushViewController(productCV, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.section
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        
    }
    
    @IBAction func favButtonTapped(_ sender: Any) {
        
        addToWishList()
        
    }
    
    func addToCart() {
        
        hud.show(in: self.view)
        
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
            print("khaled \(dic)")
            
            self?.mydic = dic
            self?.arrSlider = dic["products_images"] as! NSArray
            self?.imagesCollectionView.reloadData()
            self?.pageControl.numberOfPages = (self?.arrSlider.count)!
            self?.lblProductName.text = dic.object(forKey: "product_name") as? String
            let strPrice = String(format: "%@%@","KD ", dic.value(forKey: "product_current_price") as! CVarArg)
            self?.lblProductPrice.text = strPrice as String
            self?.lblDescription.text = dic.object(forKey: "product_description") as? String
            self?.lblBrandName.text = dic.object(forKey: "brand") as? String
            self?.lblMenufacturedIn.text = dic.object(forKey: "made_in_country") as? String
            self?.lblWeight.text = dic.object(forKey: "weight") as? String
            self?.lblMaterial.text = dic.object(forKey: "material") as? String
           // self?.widthValueLbl.text = "\((dic.object(forKey: "width") as! Int) * 2 )"
            strProductId = String(dic .value(forKey: "id") as! Int)
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
                
                
              //  self?.GetNewBlock()

                self?.recommendedCollectionView.reloadData()

              
                // self?.tblDetail.reloadData()
                
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
    
    @IBAction func incresecount(_ sender: Any) {
        
//        var count = Int(lblProductCount.text!)!
        
        count += 1

        lblProductCount.text = String(count)
    }
    
    @IBAction func decreeseCount(_ sender: Any) {
        
        count -= 1

        lblProductCount.text = String(count)
    }
    
    
//    func setupviewforcollection () {
//        
//        viewForCollection.frame =  CGRect(0, 0, self.view.frame.size.width, self.view.frame.size.height/2)
//        
//        viewForCollection.backgroundColor = UIColor.black
//
//        
//        
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//       
//        layout.scrollDirection = .horizontal
//        
//        layout.minimumInteritemSpacing = 10
//        layout.minimumLineSpacing = 10
//        recommendedCollectionView.frame = CGRect(x: 0,y: 0,width: viewForCollection.frame.size.width-22,height: viewForCollection.frame.size.height-20)
//                                          
//        recommendedCollectionView.collectionViewLayout = layout
//       
//        recommendedCollectionView.dataSource = self
//        recommendedCollectionView.delegate = self
//        recommendedCollectionView.isPagingEnabled = false
//        
//         recommendedCollectionView.register(UINib.init(nibName: "subcat2CollectionCell", bundle: nil), forCellWithReuseIdentifier: "subcat2CollectionCell")
//         recommendedCollectionView.showsVerticalScrollIndicator = false
//        
//        recommendedCollectionView.backgroundColor = UIColor.white
//        
//     //   viewForCollection.addSubview(recommendedCollectionView)
//    
//        
//        
//        pageControl = UIPageControl(frame: CGRect(0,recommendedCollectionView.frame.size.height+20,(self.view.frame.size.width),(self.pageControl.frame.size.height)))
//       // pageControl.numberOfPages = data.count
//
//        pageControl.pageIndicatorTintColor = UIColor.brown
//        pageControl.currentPageIndicatorTintColor = UIColor.white
//        viewForCollection.addSubview(pageControl)
//        
//    }
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
        
        let menuButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(menuAction))
        
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
    
    @objc func menuAction()
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
