////
////  collectionView.swift
////  Abaya
////
////  Created by Khaled Bohout on 11/7/19.
////  Copyright © 2019 Khaled Bohout. All rights reserved.
////
//
//import Foundation
//
//func setupHeaderView() {
//    let headerView: UIView = UIView.init(frame: CGRect(0, 0, self.view.frame.size.width, self.view.frame.size.height/4));
//    headerView.backgroundColor = UIColor.white
//    lblNewBlocks = UILabel(frame: CGRect(x: 15, y: 10, width: 230, height: 21))
//    lblNewBlocks.textAlignment = .center //For center alignment
//    lblNewBlocks.text = "New on Blocks"
//    lblNewBlocks.textColor = .black
//    
//    lblNewBlocks.font = UIFont(name: "Montserrat-SemiBold", size: 16)
//    
//   
//  
//    
//    //To display multiple lines in label
//    lblNewBlocks.numberOfLines = 0
//    lblNewBlocks.lineBreakMode = .byWordWrapping
//  
//    lblNewBlocks.sizeToFit()//If required
//    headerView.addSubview(lblNewBlocks)
//    
//    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//   
//    layout.scrollDirection = .horizontal
//    
//    layout.minimumInteritemSpacing = 10
//    layout.minimumLineSpacing = 10
//    collectionView = UICollectionView(frame: CGRect(x: 10,y: lblNewBlocks.frame.origin.y+lblNewBlocks.frame.size.height+10,width: headerView.frame.size.width-22,height: headerView.frame.size.height-10), collectionViewLayout: layout)
//   
//    collectionView.dataSource = self
//    collectionView.delegate = self
//    collectionView.isPagingEnabled = false
//    
//     collectionView.register(UINib.init(nibName: "subcat2CollectionCell", bundle: nil), forCellWithReuseIdentifier: "subcat2CollectionCell")
//      collectionView.showsVerticalScrollIndicator = false
//    
//    collectionView.backgroundColor = UIColor.white
//    headerView.addSubview(collectionView)
//    tblDetail.tableFooterView = headerView
//    
//    
//    pageControl = UIPageControl(frame: CGRect(0,collectionView.frame.size.height+20,(self.view.frame.size.width),(self.pageControl.frame.size.height)))
//   // pageControl.numberOfPages = data.count
//    
//    pageControl.pageIndicatorTintColor = UIColor.brown
//    pageControl.currentPageIndicatorTintColor = UIColor.white
//    tblDetail.tableHeaderView?.addSubview(pageControl)
//    
//}
//
