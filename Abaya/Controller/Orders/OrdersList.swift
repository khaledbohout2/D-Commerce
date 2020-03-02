//
//  OrdersTable.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/18/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit

class OrdersList: UITableViewController {
    
    var ordersArr = Array<Any>()
    
    var orderToCancel : Int?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        backBySwipe()
        
        tableView.register(UINib(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
    }
    
    func backBySwipe() {
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        self.tableView.addGestureRecognizer(gesture)
    }
    

    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {

        self.navigationController?.popViewController(animated: true)
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print(ordersArr.count)
        return ordersArr.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return 1
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as? OrderCell
        
        //cell!.contentView.frame.width = self.view.frame.width - 4
        
           // cell!.layer.borderWidth = 1
        //cell?.widthAnchor = self.view.frame.width - 4
           // cell!.layer.cornerRadius = 8
           // cell!.clipsToBounds = true
        
        cell?.btnTrackOrder.addTarget(self, action: #selector(buttonTrackOrdr), for: .touchUpInside)
        cell?.btnCancelOrder.addTarget(self, action: #selector(buttonCancelOrdr), for: .touchUpInside)
        //cell?.btnCancelOrder.addTarget(self, action: #selector(buttonCancelOrder), for: .touchUpInside)

        let orderDic = ordersArr[indexPath.section] as! NSDictionary
        print(orderDic)

        let orderNumber = orderDic .value(forKey: "id") as! Int
        let orderDate = orderDic .value(forKey: "created_at") as! String
        let orderStatues = orderDic .value(forKey: "order_status") as! String
        let orderItems = orderDic .value(forKey: "order_item") as! [NSDictionary]
        let orderPrice = orderDic .value(forKey: "total_price") as! Int

        let order = Order(orderNumber: orderNumber, orderDate: orderDate, orderStatues: orderStatues, orderItems: orderItems, orderprice: orderPrice)

        cell!.generateCell(order: order)

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    @objc func buttonTrackOrdr(sender: UIButton){
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        var dicuserDetail = NSDictionary()
        dicuserDetail = self.ordersArr[(indexPath?.row)!] as! NSDictionary
        orderToTrack = String(format: "%@",dicuserDetail.value(forKey: "id") as! CVarArg) as NSString
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "TrackOrderVC") as! TrackOrderVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func buttonCancelOrdr(sender: UIButton){
        
        let buttonPosition:CGPoint = sender.convert(CGPoint.zero, to:self.tableView)
        
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        
        var dicuserDetail = NSDictionary()
        
        dicuserDetail = self.ordersArr[(indexPath?.row)!] as! NSDictionary
        
        orderToCancel = dicuserDetail.value(forKey: "id") as? Int
        
        cencelOrder(id: orderToCancel!, indexPath: indexPath!.row)
        

    }
    
    func cencelOrder(id : Int,indexPath : Int) {
        
        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
        hud.show(in: self.view)
        
        let par = ["orderId" : id] as [String : Any]
        
        print(par)
        
        ApiBaseClass.apiCallingMethodeca(url: BaseUrl.cancelOrder(), parameter: par, completion: { (response) in
            let success = response["success"] as! Bool
            print(response)
            if success {
                
                hud.dismiss()
                
                self.view.makeToast(NSLocalizedString("order cancelled", comment: ""), duration: 2.0, position: .center)
                
                self.ordersArr.remove(at: indexPath)
                
                self.tableView.reloadData()
                
            } else {
                hud.dismiss()
            }
        }) { (error) in
            hud.dismiss()
            Alert.Show(title: NSLocalizedString("Not Connected", comment: ""), mesage: NSLocalizedString("please check your internet connection", comment: ""), viewcontroller: self)
        }
        
    }

}
