//
//  CategoryPageVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/7/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryPageVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UIScrollViewDelegate {

    @IBOutlet weak var scroll: UIScrollView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var viewForCollection: UIView!
    

    
    var lblNewProducts  = UILabel()
    
    var btnShowAll = UIButton()

    var lastCat = NSArray()
    
    var productsArr = NSArray()
    
    var pageControl = UIPageControl()
    
    var iD = Int()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame =  CGRect(0, 0, self.view.frame.size.width, self.view.frame.size.height+300)
        
        
        self.btnShowAll.isHidden = true
        
        self.lblNewProducts.isHidden = true
        
        self.setupviewforcollection()
        
        initialcollectionView()
        
        self.setupSegmant()
        
    }
    
    
    func setupSegmant() {
        
       // print("khaled array count is \(lastCat.count)")
       // print("khaled categgory children array \(lastCat)")
        
        if lastCat.count < 2  {
            print("k")

        }
        
        else {
        
        var dic = NSDictionary()
        
        var catNames = [String]()
            
        //var index = 0
        
        for i in lastCat {
            
            dic = i as! NSDictionary
            
            let catName = dic.value(forKey: NSLocalizedString("category_name", comment: "")) as! String
            
            catNames.append(catName)
            
//            let o = lastCat[index] as! NSDictionary
//
//            print("khaled index \(index) is \(o)")
//
//            index += 1
            
            
        }
            let segmentController = UISegmentedControl(items: catNames)
            
            segmentController.selectedSegmentIndex = 0
            
            let bounds: CGRect = UIScreen.main.bounds
            let w:Int  = Int(bounds.size.width)
           // let h:Int  = Int(bounds.size.height)
            
            segmentController.frame = CGRect(x: 15, y: 10, width: w - 30, height: 20)
            
            segmentController.addTarget(self, action: #selector(loadCollectionViewArray), for: .valueChanged)
            
            self.view.addSubview(segmentController)
            
            }
        

        
    }
    
    func initialcollectionView() {
        
        if lastCat != [] {
        
        let productsDic = lastCat[0] as! NSDictionary
        
        iD = productsDic .value(forKey: "id") as! Int
            
        categpryID = String(iD)
            print(categpryID)
        
        let strUrl = "http://theblocksapp.com/api/getAllNewProducts/\(categpryID)"
        
        getProducts(url: strUrl)
            
        }
        
        //print(strUrl)
    }

    
    @objc func loadCollectionViewArray(sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        
        let productsDic = lastCat[index] as! NSDictionary
        
         iD = productsDic .value(forKey: "id") as! Int
        
        let strUrl = "http://theblocksapp.com/api/getAllNewProducts/\(iD)"
        
        print(strUrl)
        
        getProducts(url: strUrl)
        
        //print(strUrl)
        
    }
    
    func getProducts(url: String) {
        
                ApiBaseClass.apiCallingWithGetMethode(url:url, completion: { [weak self] response in
                    let errorCheck = response["success"] as! Bool
                    var dic = NSDictionary()
                    dic = response as NSDictionary
                    if errorCheck
                    {
                        
                        
                        let dic2 = (dic["data"] as! NSDictionary)
                        
                        self?.productsArr = (dic2["data"] as! NSArray)
                        
                       // print("khaledeeee \(self?.productsArr)")

                        self?.collectionView.reloadData()
                        
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
    
    func setupviewforcollection () {
        
        let bounds: CGRect = UIScreen.main.bounds
        let w:Int  = Int(bounds.size.width)
       // let h:Int  = Int(bounds.size.height)
        
        viewForCollection.frame =  CGRect(x: 0, y: 0, width: w, height: w/2)
        
        viewForCollection.backgroundColor = UIColor.white
        lblNewProducts = UILabel(frame: CGRect(x: 15, y: 35, width: 150, height: 20))
        lblNewProducts.textAlignment = .center //For center alignment
        lblNewProducts.text = NSLocalizedString("New on Blocks", comment: "")
        lblNewProducts.textColor = .black
        
        lblNewProducts.font = UIFont(name: "Montserrat-SemiBold", size: 16)

        //To display multiple lines in label
        lblNewProducts.numberOfLines = 1
        lblNewProducts.lineBreakMode = .byWordWrapping
      
        lblNewProducts.sizeToFit()//If required
        viewForCollection.addSubview(lblNewProducts)
        
        btnShowAll = UIButton(frame: CGRect(x: (w - 110), y: 35, width: 95, height: 21))

                
        //        btnShowAll.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //        btnShowAll.translatesAutoresizingMaskIntoConstraints = false

          btnShowAll.setTitle(NSLocalizedString("Show All >>", comment: ""), for: .normal)
          btnShowAll.setTitleColor(.black, for: .normal)
          
          btnShowAll.titleLabel?.font = UIFont(name: "Montserrat-SemiBold", size: 16)
          btnShowAll.addTarget(self, action: #selector(btnShowAllTapped), for: .touchUpInside)
         // btnShowAll.sizeToFit()

          
          viewForCollection.addSubview(btnShowAll)
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       
        layout.scrollDirection = .horizontal
        
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        
        collectionView.frame = CGRect(x: 10,y: lblNewProducts.frame.origin.y+lblNewProducts.frame.size.height+8,width: viewForCollection.frame.width-22,height: viewForCollection.frame.height-20)
                                          
        collectionView.collectionViewLayout = layout
       
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = false
        
         collectionView.register(UINib.init(nibName: "subcat2CollectionCell", bundle: nil), forCellWithReuseIdentifier: "subcat2CollectionCell")
         collectionView.showsVerticalScrollIndicator = false
        
        collectionView.backgroundColor = UIColor.white
        
        viewForCollection.addSubview(collectionView)
    
        
        
        pageControl = UIPageControl(frame: CGRect(0,collectionView.frame.size.height+20,(self.view.frame.size.width),(self.pageControl.frame.size.height)))
       // pageControl.numberOfPages = data.count

        pageControl.pageIndicatorTintColor = UIColor.brown
        pageControl.currentPageIndicatorTintColor = UIColor.white
        viewForCollection.addSubview(pageControl)
        
    }
    
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
           // self.setupviewforcollection()

        }
    
    //MARK: - check that
        internal func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
      
            func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: (self.collectionView.frame.width/3), height: (self.collectionView.frame.height
            ))
        }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
      //  print(" khaled \(productsArr.count)")
        return productsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
         {
           self.pageControl.currentPage = indexPath.section
         }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subcat2CollectionCell", for: indexPath) as! subcat2CollectionCell
                   
                   var dic = NSDictionary()
                   
                   dic = productsArr[indexPath.row] as! NSDictionary
                   
                   cell.lblName.text = (dic.value(forKey: "product_name") as? String)!
        
                   cell.lblBrand.text = (dic.value(forKey: "brand") as? String)!
                   
                   let strimgUrl = .imagebaseURL + "products/" + (dic.value(forKey: "product_image") as? String)!
                   let fileUrl = NSURL(string: strimgUrl)
                   
                   cell.img.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                   })
   
                   return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dic = productsArr[indexPath.row] as! NSDictionary
        
        let x : Int = dic.value(forKey: "product_id") as! NSInteger
        
        
        
        strProductId = String(x)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let productCV = storyboard.instantiateViewController(withIdentifier: "productVC") as! ProductDetail
        
        self.navigationController?.pushViewController(productCV, animated: true)

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Change the current page
        let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
        let index = scrollView.contentOffset.x / witdh
        let roundedIndex = round(index)
        pageControl.currentPage = Int(roundedIndex)
        
    }
    
            @objc func btnShowAllTapped(sender: UIButton){
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "ProductListVC")
                categpryID = String(iD)
                self.navigationController?.pushViewController(vc, animated: true)

        }

           

}



