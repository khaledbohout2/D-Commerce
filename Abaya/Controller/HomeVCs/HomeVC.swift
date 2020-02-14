//
//  NewHomeVC.swift
//  Blocks
//
//  Created by Khaled Bohout on 1/27/20.
//  Copyright © 2020 Khaled Bohout. All rights reserved.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    
    @IBOutlet weak var categoriesTableView: UITableView!
    
    @IBOutlet weak var bannersCollectionView: UICollectionView!

    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var categoriesCollectionWidth: NSLayoutConstraint!
    // @IBOutlet weak var collectionViewHieght: NSLayoutConstraint!
    
    var arrSlider = NSArray()
    
    var arrSubCategoryList = NSArray()
    
    var arrStoreList = NSArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesCollectionWidth.constant = self.view.frame.width
        
       // collectionViewHieght.constant = self.view.frame.size.width
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        
        bannersCollectionView.delegate = self
        bannersCollectionView.dataSource = self
        bannersCollectionView.isPagingEnabled = true
        
        bannersCollectionView.register(UINib.init(nibName: "HomeSliderCell", bundle: nil), forCellWithReuseIdentifier: "HomeSliderCell")
        
        categoriesTableView.register(UINib(nibName: "storeCell", bundle: nil), forCellReuseIdentifier: "storeCell")
        
        GetCategoryApi()
        
        setupNavButtons()
        // Do any additional setup after loading the view.
    }
    

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           

           let cell = tableView.dequeueReusableCell(withIdentifier: "storeCell", for: indexPath as IndexPath) as! storeCell
           
           
           var dic = NSDictionary()
           
           dic = CategoryList[indexPath.row] as! NSDictionary
           
           
           print(dic)
           
           cell.store_name.text = (dic.value(forKey: NSLocalizedString("category_name", comment: "")) as? String)!
           
           cell.store_coutry.text = "Slogan"

           cell.store_coutry.textColor = UIColor.white
           
           cell.store_name.textColor = UIColor.white
           
           let strurl = .imagebaseURL + "category/" + (dic.value(forKey: "category_image") as! String)
           
           let fileUrl = URL(string: strurl)

           cell.store_imageimage.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: "store_cover_two"),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
           })

           cell.selectionStyle = .none
    
               return cell

       }

       
       func numberOfSections(in tableView: UITableView) -> Int {
           
           return 1
       }
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {


           
           return CategoryList.count

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
           
           var dic = NSDictionary()
           dic = CategoryList[indexPath.row] as! NSDictionary
                
           
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           
           let categoryVC = storyboard.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
           
         //  categoryVC.dicDetail = dicDetail
        
        categoryVC.categoryDic = dic
        
        
           
          

           self.navigationController?.pushViewController(categoryVC, animated: true)

          }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrSlider.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.bannersCollectionView.frame.width), height: (self.bannersCollectionView.frame.height
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

    
//    func startTimer() {
//
//        _ =  Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
//    }
//
//
//    @objc func scrollAutomatically(_ timer1: Timer) {
//
//        if let coll  = bannersCollectionView {
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
                print(CategoryList)
                self?.categoriesTableView.reloadData()
                self?.GetBannerApi()
                
                hud.dismiss()
                //self?.addPageMenu(count: (CategoryList.count))
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
    

    func GetBannerApi()
    {
        
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getbannerapi(), completion: { [weak self] response in
            let errorCheck = response["success"] as! Bool
            var dic = NSDictionary()
            dic = response as NSDictionary
            if errorCheck
            {
                

                 self?.arrSlider = (dic["data"] as! NSArray)
                
                self?.bannersCollectionView.reloadData()
              //  self!.collectionViewHieght.constant = self!.view.frame.size.width
               // self?.bannersCollectionView.constant = self!.view.frame.size.width
                self?.pageControl.numberOfPages = (self?.arrSlider.count)!
            //    self!.startTimer()
                
            }
            else
            {
                
                                  Alert.Show(title:NSLocalizedString("something wrong", comment: ""), mesage: NSLocalizedString("Please try again.", comment: ""), viewcontroller:self!)
                                    
                                }
                                }, failure: { [weak self] failResponse in
                                    hud.dismiss()
                                    Alert.Show(title: NSLocalizedString("network error", comment: ""), mesage:NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
        })
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
                    
                    
                //    self?.GetNewBlock()

                //    self?.collectionView.reloadData()

                  
                     self?.categoriesTableView.reloadData()


    //                DispatchQueue.main.async {
    //
    //                    var frame = self?.view.frame
    //                    frame!.size.height = self!.tblDetail.contentSize.height
    //                    self!.view.frame = frame!
    //
    //                }
                    
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
