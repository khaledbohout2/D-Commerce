//
//  TrackOrderVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/18/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import SDWebImage

class TrackOrderVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var orderItems = NSArray()
    var mydic = NSDictionary()
    var itemsCount = NSInteger()
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    
    
    
    @IBOutlet weak var orederDateLbl: UILabel!
    
    @IBOutlet weak var orderStateLbl: UILabel!
    
    @IBOutlet weak var OrderNumberLbl: UILabel!
    
    @IBOutlet weak var orderTotalPriceLbl: UILabel!
    
    @IBOutlet weak var orderPlacedLbl: UILabel!
    
    @IBOutlet weak var orderDispatchedLbl: UILabel!
    
    @IBOutlet weak var onTransitLbl: UILabel!
    
    @IBOutlet weak var expectedDeliveryLbl: UILabel!
    
    
    @IBOutlet weak var tblheight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self

        itemsTableView.register(UINib(nibName: "OrderItemCell", bundle: nil), forCellReuseIdentifier: "OrderItemCell")
        
        getOrder()
        
      //  itemsTableView.frame.height = orderItems.count * 128

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        tblheight.constant = CGFloat(orderItems.count * 128) + 22
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = itemsTableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as! OrderItemCell
        
        let itemDic = orderItems[indexPath.row] as! NSDictionary
        
        let productPrice = itemDic .value(forKey: "total_price") as! Int
        
        cell.ProductPrice.text = "KD " + String(productPrice)
        
        let productDic = itemDic .value(forKey: "product") as! NSDictionary
        
        let productName = productDic .value(forKey: "product_name") as! String
        
        cell.productName.text = productName
        
        let ProductBrand = productDic .value(forKey: "brand") as! String
        
        cell.productBrand.text = ProductBrand
        
        let strimgUrl = .imagebaseURL + "products/" + (productDic .value(forKey: "product_image") as? String)!
        let fileUrl = NSURL(string: strimgUrl)
        
        cell.itemImageView.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
        })

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(itemsCount) + " items"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 22
    }
    

    
    func getOrder()
    {
        DicParameters = [:]
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)
        
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getOrderToTrack(), completion: { [weak self] response in
            
          //  print("khaled basha \(ApiBaseClass.getShopProductDetail())")
            
            var dic = NSDictionary()
            
            dic = response["data"] as! NSDictionary
          //  print("khaled \(dic)")
            
            self?.mydic = dic
            self?.orderItems = dic .value(forKey: "order_item") as! NSArray
            self?.itemsCount = self!.orderItems.count
            self?.orederDateLbl.text = dic .value(forKey: "created_at") as? String
            self?.orderStateLbl.text = dic .value(forKey: "order_status") as? String
            self?.orderTotalPriceLbl.text = "KD " + String(dic .value(forKey: "total_price") as! Int)
            self?.OrderNumberLbl.text = String(dic .value(forKey: "id") as! Int)
            self?.orderPlacedLbl.text = dic .value(forKey: "created_at") as? String
            self?.itemsTableView.reloadData()
            
            hud.dismiss()
            
            }, failure: { [weak self] failResponse in
                hud.dismiss()
                Alert.Show(title: NSLocalizedString("network error", comment: "") , mesage: NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
        })
    }




}
