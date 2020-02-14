//
//  CountryStateVC.swift
//  Abaya
//
//  Created by Rajendra Kumar on 18/04/19.
//  Copyright © 2019 Kareem Mohammed. All rights reserved.
//

var strCountryID = NSString()
var strCountryName = NSString()

var strStateID = NSString()
var strStateName = NSString()



import UIKit

protocol SetState {
    
    func didSetState ()
    
}

class CountryStateVC: UIViewController {
    @IBOutlet weak var tblCountry: UITableView!
    
    var arrCountry = NSArray()
    
    var delegate : SetState?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblCountry.isHidden = true
        
        tblCountry.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "CountryCell")
        tblCountry.allowsMultipleSelection = false
        
        setupNavButtons()
        
        if isCountry == true {

            GetCountryList()
        }
        else
        {
            GetStateList()

        }
        

    }

    func GetCountryList()
    {
        DicParameters = [:]
        hud.textLabel.text = "Loading"
        hud.show(in: self.view)
        ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getCountryList(), completion: { [weak self] response in
            let errorCheck = response["success"] as! Bool
            
            if errorCheck
            {
                //                    self?.obj.responseFromJson(dic:response)
                
                var dic = NSDictionary()
                dic = response as NSDictionary
                let countries = dic["data"] as! NSArray
                
                print(countries)
                
                for country in countries {
                    
                    if (country as! NSDictionary).value(forKey: "id") as! Int == 117 {
                        self!.arrCountry = [country]
                    }
                }
              //  countries = dic["data"] as! NSArray
                self?.tblCountry.reloadData()
                hud.dismiss()
                self?.tblCountry.isHidden = false
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



func GetStateList()
{
  //  DicParameters = ["/":strCountryID] as [String : String]
    hud.textLabel.text = "Loading"
    hud.show(in: self.view)
    ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.getStateList(), completion: { [weak self] response in
        let errorCheck = response["success"] as! Bool
        
        if errorCheck
        {
            //                    self?.obj.responseFromJson(dic:response)
            
            var dic = NSDictionary()
            dic = response as NSDictionary
            self?.arrCountry = dic["data"] as! NSArray
           // print(self?.arrCountry as Any)
            self?.tblCountry.reloadData()
            hud.dismiss()
            self?.tblCountry.isHidden = false

        }
        else
        {
            hud.dismiss()
            Alert.Show(title:"something wrong", mesage:"Please try again.", viewcontroller:self!)
        }
        }, failure: { [weak self] failResponse in
            hud.dismiss()
            Alert.Show(title:"network error", mesage:"Please try again.", viewcontroller:self!)
    })
}

}
// MARK: - Table View Data Source

extension CountryStateVC: UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath as IndexPath) as! CountryCell
        cell.selectionStyle = .none
        
        var dic = NSDictionary()
        
         if isCountry == true {
            
            dic = arrCountry[indexPath.row] as! NSDictionary
            cell.lblName.text = dic .object(forKey: "country") as?String
                
            }
            
         else{
           
            dic = arrCountry[indexPath.row] as! NSDictionary
            cell.lblName.text = dic .object(forKey: "state") as?String
        }
        
        
       

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        _ = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath as IndexPath) as! CountryCell
        
        var dic = NSDictionary()
        
        dic = arrCountry[indexPath.row] as! NSDictionary
        
        if isCountry == true {
            
            strCountryName = (dic .object(forKey: "country") as? NSString)!
            strCountryID = String(format: "%@", dic.value(forKey: "id") as! CVarArg) as NSString
            delegate?.didSetState()
            self.navigationController?.popViewController(animated: true)
        }
            
        else {
           
            
            strStateName = (dic .object(forKey: "state") as? NSString)!
            strStateID = String(format: "%@", dic.value(forKey: "id") as! CVarArg) as NSString
            delegate?.didSetState()
            self.navigationController?.popViewController(animated: true)

            

        }
        
        
        
        
        }
}
// MARK:- Navigation
extension CountryStateVC {
    
    func setupNavButtons() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        if isCountry == true {
            self.title = "Select Country"
        }
        else{
            self.title = "Select City"
        }
        
        
        
        let backButton = UIBarButtonItem(image: UIImage(named: "back_arrow"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    @objc func backAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
   }

