////
////  CartVC2.swift
////  Abaya
////
////  Created by Khaled Bohout on 1/9/20.
////  Copyright © 2020 Khaled Bohout. All rights reserved.
////
//
//import UIKit
//
//class CartVC2: UIViewController {
//
//    var arrCart = NSArray()
//    
//    
//    @IBOutlet weak var tblCart: UITableView!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//    
//    func GetCartList()
//        
//    {
//        DicParameters = [:]
//        
//        
//        hud.textLabel.text = NSLocalizedString("Loading", comment: "")
//        hud.show(in: self.view)
//        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getCartList(), completion: { [weak self] response in
//            let errorCheck = response["success"] as! Bool
//            
//            if errorCheck
//            {
//                
//                var dic = NSDictionary()
//                 dic = response as NSDictionary
//              //  print("cart list is\(dic)")
//                
//
//                if let dicData = (dic["data"] as? NSDictionary) {
//                
//               // print("khaled123 \(dicData)")
//                
//             //   self!.dicBillInfo = (dicData["billInfo"] as! NSDictionary)
//                
//                
//                let arrdata = (dicData["cartInfo"] as! NSArray)
//                self?.arrCart = arrdata.mutableCopy() as! NSMutableArray
//               // print(self?.arrCart as Any)
//                self?.tblCart.reloadData()
//                self?.tblCart.isHidden = false
////                DispatchQueue.main.async {
////                    self!.tableHeight?.constant = self!.tblCart.contentSize.height
////                    self!.contantViewHeight?.constant = self!.tblCart.contentSize.height
////                }
//                    
//                 hud.dismiss()
//            
//                } else if (dic["data"] as? NSArray) != nil {
//                    
//                    hud.dismiss()
//                    
//                    self?.tblCart.isHidden = true
//                    Alert.Show(title: "", mesage: "cart is empty", viewcontroller: self!)
//
//            
//            }
//            }
//            else
//            {
//                        hud.dismiss()
//                              Alert.Show(title:NSLocalizedString("something wrong", comment: ""), mesage: NSLocalizedString("Please try again.", comment: ""), viewcontroller:self!)
//                                
//                            }
//                            }, failure: { [weak self] failResponse in
//                                hud.dismiss()
//                                Alert.Show(title: NSLocalizedString("network error", comment: ""), mesage:NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
//                                
//                })
//    }
//    
//    
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
//
//extension CartVC2: UITableViewDelegate,UITableViewDataSource  {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if (section == 0) {
//            
//            
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//}
