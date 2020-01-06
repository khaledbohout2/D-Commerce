//
//  SearchVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/25/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    var searchValues = [String]()
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
        
        tableView.isHidden = true
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == ""
        {
            view.endEditing(true)
            tableView.isHidden = true
        }
        else {
            
           
            searchBar.showsCancelButton = false
            tableView.isHidden = false
            textTosearch = searchText.lowercased()
            autoCompleteSearch()
                        
        }

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        tableView.isHidden = true
        productToFilter = searchBar.text!
        print(productToFilter)
        
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchResultsVC") as! SearchResultsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func autoCompleteSearch () {
        
                  DicParameters = [:]
                  hud.textLabel.text = NSLocalizedString("Loading", comment: "")
                  hud.show(in: self.view)
                  ApiBaseClass.apiCallingWithGetMethode(url:ApiBaseClass.searchAutoComplete(), completion: { [weak self] response in
                      let errorCheck = response["success"] as! Bool
          
                      if errorCheck
                        
                      {
                        
                        hud.dismiss()
                        let dic = response as NSDictionary
                        let arr = dic .value(forKey: "data") as! [String]
                        self!.searchValues = arr
                        self!.tableView.reloadData()
                        
  
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
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        
        searchBar.text = ""
        view.endEditing(true)
        self.searchValues = []
        self.tableView.reloadData()
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = searchValues[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        productToFilter = searchValues[indexPath.row]
        print(productToFilter)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchResultsVC") as! SearchResultsVC
        self.navigationController?.pushViewController(vc, animated: true)

    }
}

// MARK:- Navigation
extension SearchVC {
    
    func setUpNavigation() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black

        

        let closeButton = UIBarButtonItem(image: #imageLiteral(resourceName: "close_icon"), style: .plain, target: self, action: #selector(closeButtonfunc))
        self.navigationController?.navigationBar.tintColor = UIColor.black

        navigationItem.rightBarButtonItem = closeButton
        
        self.title = NSLocalizedString("Search", comment: "")
        
       // navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.backgroundColor = UIColor.white
        
        navigationController?.navigationBar.setNeedsLayout()
        
    }
    
    @objc func closeButtonfunc(sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
    

    
}

