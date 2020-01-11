//
//  HomePageVC.swift
//  Abaya
//
//  Created by khaled Bohout on 11/03/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import Alamofire
import JGProgressHUD
import SDWebImage


class HomePageVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    
    var obj = HelpDictionaryModelClass()
    var objNewBlocks = newStorOneBlocksModelClass()
    

    var nav  = UINavigationController()
    
    var strbtnTag = String()
    var catId = String()
    var lblNewBlocks  = UILabel()
    var btnShowAll = UIButton()
    var username: String = ""
    var arrSubCategoryList = NSArray()
    var arrSubCategoryList_2 = NSArray()
    var arrNewBlocks = NSArray()
    var fromSideMenue = false
    
    @IBOutlet var collectionView: UICollectionView!
    var hud = JGProgressHUD(style: .extraLight)
    var arrStore = NSArray()
    var arrStoreList = NSArray()
    /////
    @IBOutlet var tblDetail: UITableView!
    
    var pageControl = UIPageControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.delegate = self
        self.lblNewBlocks.isHidden = true
        
        tblDetail.estimatedRowHeight = 44.0
        tblDetail.rowHeight = UITableView.automaticDimension

        tblDetail.tableFooterView = UIView()
        tblDetail.delegate = self
        tblDetail.dataSource = self
        
        tblDetail.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0);

        tblDetail.register(UINib(nibName: "storeCell", bundle: nil), forCellReuseIdentifier: "storeCell")
        
        if !fromSideMenue {
            
        self.setupHeaderView()
            
             collectionView.dataSource = self
             collectionView.delegate = self
             collectionView.register(UINib.init(nibName: "subCatCell", bundle: nil), forCellWithReuseIdentifier: "subCatCell")
             collectionView.register(UINib.init(nibName: "FooterCell", bundle: nil), forCellWithReuseIdentifier: "FooterCell")
             strbtnTag=username
             
            // print(arrSubCategoryList)
            
            self.GetStoreList()

        }
        
        
       // print(arrSubCategoryList)
        
        
    }
    
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
//            self.view.frame.size = CGSize(width: self.view.frame.size.width, height:tblDetail.contentSize.height + 300)

    //        DispatchQueue.main.async {
    //            self.tableHeight?.constant = self.tblCart.contentSize.height
    //        }

        }

    
    override func viewDidAppear(_ animated: Bool)
    {
      
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .clear
        //obj.helplineList.removeAll()
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func setupHeaderView() {
        let headerView: UIView = UIView.init(frame: CGRect(0, 0, self.view.frame.size.width, self.view.frame.size.height/2));
        headerView.backgroundColor = UIColor.white
        
        lblNewBlocks = UILabel(frame: CGRect(x: 15, y: 10, width: 230, height: 21))
        lblNewBlocks.textAlignment = .center //For center alignment
        lblNewBlocks.text = NSLocalizedString("New on Blocks", comment: "")
        lblNewBlocks.textColor = .black
        
        lblNewBlocks.font = UIFont(name: "Montserrat-SemiBold", size: 16)
        
       
      
        
        //To display multiple lines in label
        lblNewBlocks.numberOfLines = 0
        lblNewBlocks.lineBreakMode = .byWordWrapping
      
        lblNewBlocks.sizeToFit()//If required
        headerView.addSubview(lblNewBlocks)
        
        btnShowAll = UIButton(frame: CGRect(x: self.view.frame.width - 180, y: 10, width: 230, height: 21))

        
//        btnShowAll.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        btnShowAll.translatesAutoresizingMaskIntoConstraints = false

          btnShowAll.setTitle(NSLocalizedString("Show All >>", comment: ""), for: .normal)
          btnShowAll.setTitleColor(.black, for: .normal)
          
          btnShowAll.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
          btnShowAll.addTarget(self, action: #selector(btnShowAllTapped), for: .touchUpInside)

          lblNewBlocks.sizeToFit()//If required
          headerView.addSubview(btnShowAll)
        
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       
        layout.scrollDirection = .horizontal
        
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: CGRect(x: 10,y: lblNewBlocks.frame.origin.y+lblNewBlocks.frame.size.height+10,width: headerView.frame.size.width-22,height: headerView.frame.size.height-10), collectionViewLayout: layout)
       
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = false
        
         collectionView.register(UINib.init(nibName: "subcat2CollectionCell", bundle: nil), forCellWithReuseIdentifier: "subcat2CollectionCell")
          collectionView.showsVerticalScrollIndicator = false
        
        collectionView.backgroundColor = UIColor.white
        headerView.addSubview(collectionView)
        tblDetail.tableFooterView = headerView
        
        
        pageControl = UIPageControl(frame: CGRect(0,collectionView.frame.size.height+20,(self.view.frame.size.width),(self.pageControl.frame.size.height)))

        pageControl.pageIndicatorTintColor = UIColor.brown
        pageControl.currentPageIndicatorTintColor = UIColor.white
        tblDetail.tableHeaderView?.addSubview(pageControl)
        
    }


    func GetStoreList()
    {

        hud.textLabel.text = NSLocalizedString("Loading", comment: "") 
        
        hud.show(in: self.view)
        
        var resultString = String()
        
        let ApiUrl = "http://theblocksapp.com/api/getAllNewProducts/"
        
        let limit = "?limit=5"
      
        resultString = "\(ApiUrl)\(limit)"
      
       
        ApiBaseClass.apiCallingWithGetMethode(url:resultString, completion: { [weak self] response in
            
            let errorCheck = response["success"] as! Bool
            
            var dic = NSDictionary()
            
            dic = response as NSDictionary
            
            if errorCheck
            {
                var dicData = NSDictionary()
                
                dicData = dic["data"]  as! NSDictionary
                
         //       print(dicData)
                
                
                self?.arrStoreList  = dicData.value(forKey: "data") as!NSArray
                
                
                self?.GetNewBlock()

                self?.collectionView.reloadData()

              
                 self?.tblDetail.reloadData()
//
//                DispatchQueue.main.async {
//
//                    var frame = self?.view.frame
//                    frame!.size.height = self!.tblDetail.contentSize.height
//                    self!.view.frame = frame!
//
//                }
                
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
    //getNewBlock
    
    func GetNewBlock()
    {
        
       
        
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.newStoresonBlocks(), completion: { [weak self] response in
            
            let errorCheck = response["success"] as! Bool
            
            var dic = NSDictionary()
            
            dic = response as NSDictionary
            
            if errorCheck
            {

                var dicData = NSDictionary()
                
                dicData = dic["data"]  as! NSDictionary
                
               // print(dicData)
                
                self?.arrNewBlocks  = dicData.value(forKey: "data") as!NSArray
                
               // print(self?.arrNewBlocks as Any)
                
                self?.setupHeaderView()
                
                self?.collectionView.reloadData()
                
                self?.lblNewBlocks.isHidden = false
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
    
//    override func viewDidLayoutSubviews() {
//
//       // self.setupHeaderView()
//
//    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrNewBlocks.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.width/3), height: (self.collectionView.frame.height
        ))
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subcat2CollectionCell", for: indexPath) as! subcat2CollectionCell
        

        var dic = NSDictionary()
        
        dic = arrNewBlocks[indexPath.row] as! NSDictionary
        
     
        
        let strimgUrl = .imagebaseURL + "products/" + (dic.value(forKey: "product_image") as? String)!
        let fileUrl = NSURL(string: strimgUrl)
        
        cell.img.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let dic = arrNewBlocks[indexPath.row] as! NSDictionary
        
        let x : Int = dic.value(forKey: "product_id") as! NSInteger
        
        
        
        strProductId = String(x) 
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let productCV = storyboard.instantiateViewController(withIdentifier: "productVC") as! ProductDetail
        
        self.navigationController?.pushViewController(productCV, animated: true)


    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
         {
           self.pageControl.currentPage = indexPath.section
         }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath as IndexPath) as! storeCell
        
        
        var dic = NSDictionary()
        
        dic = arrSubCategoryList[indexPath.row] as! NSDictionary
        
        
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

    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        
        return arrSubCategoryList.count
        

        
    }
    
    
    
    private func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Change the current page
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        pageControl.currentPage = Int(roundedIndex)
        //
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
       
        return self.view.frame.size.width/2
        
       // return 50
      
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)

        let dicDetail = arrSubCategoryList[indexPath.row] as! NSDictionary
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
        
        categoryVC.dicDetail = dicDetail
        
        hud.dismiss()

        self.navigationController?.pushViewController(categoryVC, animated: true)

       }
    
        func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {


        if (navigationController.viewControllers.count > 1)
        {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
            navigationController.interactivePopGestureRecognizer?.isEnabled = true;
        }
        else
        {
             self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
            navigationController.interactivePopGestureRecognizer?.isEnabled = false;
        }
    }
    
    //MARK: - check that
        internal func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }
    
        @objc func btnShowAllTapped(sender: UIButton){
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ProductListVC")
            self.navigationController?.pushViewController(vc, animated: true)

        
    }
        
}
