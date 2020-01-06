//
//  OrderConfirmVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/10/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit

class OrderConfirmVC: UIViewController {

    @IBOutlet weak var viewBox: UIView!
    
    @IBOutlet var dashedView: UIView!
    
    @IBOutlet weak var dateTextField: UILabel!
    
    @IBOutlet weak var timeTextField: UILabel!
    
    @IBOutlet weak var subTotalTextField: UILabel!
    
    @IBOutlet weak var street1Lbl: UILabel!
    
    @IBOutlet weak var street2Lbl: UILabel!
    
    @IBOutlet weak var cityLbl: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        drawDottedLine(start: CGPoint(x: dashedView.bounds.minX, y: dashedView.bounds.minY), end: CGPoint(x: dashedView.bounds.maxX, y: dashedView.bounds.minY), view: dashedView)
        
        
        viewBox.frame = CGRect(x: 33, y: viewBox.frame.origin.y, width: self.view.frame.size.width-66, height: 450)
        viewBox.layer.cornerRadius = 4
        viewBox.backgroundColor = UIColor.white
        viewBox.layer.shadowOffset = CGSize(width: 0, height: 1)
        viewBox.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.1).cgColor
        viewBox.layer.shadowOpacity = 1
        viewBox.layer.shadowRadius = 4
       // self.view.addSubview(viewBox)
        setupNavButtons()
        getOrders()
    }

    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [15, 5] // 7 is the length of dash, 3 is length of the gap.
        
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
    func getOrders() {
        
        hud.textLabel.text = "loading"
        hud.show(in: self.view)
        
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getUsersOrders(), completion: { [weak self] response in
            
            let errorCheck = response["success"] as! Bool
            var dic = NSDictionary()
            dic = response as NSDictionary
            if errorCheck
            {
                
                let dic = (dic["data"] as! NSDictionary)
                
                let dic2 = dic.value(forKey: "data") as! NSArray
                
                let order = dic2.firstObject as! NSDictionary
                
                print(order)
                
                let total_price = order.value(forKey: "total_price") as! Int
                
                let price = String(total_price)
                
                self!.subTotalTextField.text = price + NSLocalizedString("KD ", comment: "")
                
                let created_at = order.value(forKey: "created_at") as! String
                
                self!.dateTextField.text = created_at
                
                let dicadd = addressDic
                
                let address1 = dicadd .value(forKey: "address1") as! String
                
                self!.street1Lbl.text = address1
                
                let address2 = dicadd .value(forKey: "address2") as! String
                
                self!.street2Lbl.text = address2
                
                let city = dicadd .value(forKey: "city") as! String
                
                self!.cityLbl.text = city
                
                hud.dismiss()
                
            }
            else
            {
                hud.dismiss()
                
                  Alert.Show(title:NSLocalizedString("something wrong", comment: ""), mesage: NSLocalizedString("Please try again.", comment: ""), viewcontroller:self!)
                    
                }
                }, failure: { [weak self] failResponse in
                    //self?.hud.dismiss()
                    Alert.Show(title: NSLocalizedString("network error", comment: ""), mesage:NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
        })
        


    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        
        let homeVC = HomeVC(nibName: "productDetail", bundle: nil)
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
}

// MARK:- Navigation
extension OrderConfirmVC {
    
    func setupNavButtons() {
        
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.title = NSLocalizedString("Order Saved"
, comment: "")         
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backAction))
        
        navigationItem.leftBarButtonItem = backButton
        
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    @objc func backAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
}


