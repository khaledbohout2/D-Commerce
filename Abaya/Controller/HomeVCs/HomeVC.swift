//
//  HomeVC.swift
//  Abaya
//
//  Created by khaled Bohout on 11/03/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import SDWebImage

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UIScrollViewDelegate {
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet var lblBrowseShops: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!
    
    var arrSlider = NSArray()
    var arrNewArr = NSArray()
    
     private let topInset : CGFloat = 240
    private var isFading = false
    
    var hud = JGProgressHUD(style: .extraLight)
     var pageMenu : CAPSPageMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewHeight.constant = self.view.frame.size.width
        
          self.view.frame =  CGRect(0, 0, self.view.frame.size.width, self.view.frame.size.height + self.view.frame.size.width)
        
    

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        
        collectionView.register(UINib.init(nibName: "HomeSliderCell", bundle: nil), forCellWithReuseIdentifier: "HomeSliderCell")
        
        self.GetBannerApi()
        
        
        setupNavButtons()

        
//        GetCategoryApi()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
            }
    @objc func btnbackaction()
    {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews()
    {
        
        
        scroll.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height+375)

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }

    
  
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrSlider.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width), height: (self.collectionView.frame.height
        ))
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeSliderCell", for: indexPath) as! HomeSliderCell
        
        var dic = NSDictionary()
        
        dic = arrSlider[indexPath.row] as! NSDictionary
        
        let strimgUrl = .imagebaseURL + "banners/" + (dic.value(forKey: "banner") as? String)!
        
        let fileUrl = NSURL(string: strimgUrl)
        
        cell.imgSlider.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: "store_cover_two"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {

        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        pageControl.currentPage = Int(indexPath.row)
    }
    

    func startTimer() {

        _ =  Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
    }


    @objc func scrollAutomatically(_ timer1: Timer) {

        if let coll  = collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)! < arrSlider.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)

                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }

            }
        }
    }

    override func viewDidAppear(_ animated: Bool)
    {
        
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
                
                self?.hud.dismiss()
                self?.addPageMenu(count: (CategoryList.count))
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
    func GetBannerApi()
    {
        
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getbannerapi(), completion: { [weak self] response in
            let errorCheck = response["success"] as! Bool
            var dic = NSDictionary()
            dic = response as NSDictionary
            if errorCheck
            {
                

                 self?.arrSlider = (dic["data"] as! NSArray)
                
                self?.collectionView.reloadData()
                self?.collectionViewHeight.constant = self!.view.frame.size.width
                self?.pageControl.numberOfPages = (self?.arrSlider.count)!
                self!.startTimer()
                self?.GetCategoryApi()
                
            }
            else
            {
                
                                  Alert.Show(title:NSLocalizedString("something wrong", comment: ""), mesage: NSLocalizedString("Please try again.", comment: ""), viewcontroller:self!)
                                    
                                }
                                }, failure: { [weak self] failResponse in
                                    self?.hud.dismiss()
                                    Alert.Show(title: NSLocalizedString("network error", comment: ""), mesage:NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
        })
    }
}


// MARK:- Navigation
extension HomeVC {
    
    func setupNavButtons() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false 
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black

        
        let menuButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "menuIcon"), style: .plain, target: self, action: #selector(menuAction))
        
        navigationItem.leftBarButtonItem = menuButtonItem
        
        let favButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "shoppingBagIcon"), style: .plain, target: self, action:#selector(openCart))
        let searchButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "searchIcon"), style: .plain, target: self, action: #selector(searchAction))
        self.navigationController?.navigationBar.tintColor = UIColor.black;

        navigationItem.rightBarButtonItems = [searchButtonItem, favButtonItem]
        
        self.title = NSLocalizedString("HOME", comment: "")
        
        navigationController?.navigationBar.setNeedsLayout()
        
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func menuAction()
    {
        
        let signed = getUserDetails()
        
        if signed {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SliderMenuVC")
        let navController = UINavigationController(rootViewController: controller)
        self.navigationController?.present(navController, animated: true, completion: nil)
        } else {
            Alert.showSignUpAlert(viewcontroller: self)
        }
        
    }
    
    @objc func openCart() {
        
        let signed = getUserDetails()
        
        if signed {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let obj = storyboard.instantiateViewController(withIdentifier: "CartVC") as! CartVC
        self.navigationController?.pushViewController(obj, animated: true)
        } else {
            Alert.showSignUpAlert(viewcontroller: self)
        }
    }
    
    @objc func searchAction()
        
    {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchVC
                self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {
        //Your dismiss code
        //Here you should implement your checks for the swipe gesture
    }
    
}

extension HomeVC {
    
   
    func addPageMenu(count: Int) {
        var controllerArray : [UIViewController] = []
       // print(CategoryList)
       
        var dic = NSDictionary()
        
        for  i in CategoryList {
            
             var controller = HomePageVC()
             controller  = HomePageVC(nibName: "SubCategory1", bundle: nil)
            
               controllerArray.append(controller)
            
               dic = i as! NSDictionary
            
               controller.title = dic.value(forKey: NSLocalizedString("category_name", comment: "")) as? String
               controller.arrSubCategoryList = dic.value(forKey: "children") as! NSArray
            
           // controller.arrSubCategoryList_2 = dic.value(forKey: "children") as! NSArray
            
            
            
        }
        
        let parameters = [CAPSPageMenuOptionScrollMenuBackgroundColor: UIColor.clear,
                          CAPSPageMenuOptionViewBackgroundColor: UIColor.white,
                          CAPSPageMenuOptionSelectionIndicatorColor: UIColor.black,
                          CAPSPageMenuOptionBottomMenuHairlineColor: UIColor.clear,
                          CAPSPageMenuOptionSelectedMenuItemLabelColor: UIColor.black,
                          CAPSPageMenuOptionUnselectedMenuItemLabelColor: UIColor.lightGray,
                          CAPSPageMenuOptionMenuItemSeparatorWidth:self.view.frame.width/2.2,
                          CAPSPageMenuOptionMenuItemFont: UIFont(name: "HelveticaNeue", size: 15.0)!, CAPSPageMenuOptionMenuHeight: 50.0, CAPSPageMenuOptionMenuItemWidth: self.view.frame.width/4.5, CAPSPageMenuOptionCenterMenuItems: true] as [String : Any]
        
        // Initialize scroll menu
       
            pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRect(x: self.view.frame.origin.x, y: lblBrowseShops.frame.origin.y+lblBrowseShops.frame.size.height+5, width: self.view.frame.width, height: self.view.frame.height - collectionView.frame.size.height), options: parameters)
       
        pageMenu?.view.backgroundColor = UIColor.clear
        self.addChild(pageMenu!)
        contentView.addSubview(pageMenu!.view)
        //pageMenu!.didMove(toParentViewController: self)
        pageControl.isHidden = false
        lblBrowseShops.isHidden = false
    }
}
