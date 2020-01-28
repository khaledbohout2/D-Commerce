//
//  GatwayVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/22/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import WebKit

class GatwayVC: UIViewController,WKUIDelegate {
    
    var url: String!
    
    var urls = [String]()
    
    var webView: WKWebView!
    
    override func loadView() {
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == "estimatedProgress" {
            
            let url = "\(webView.url!)"
            print(url)
            urls.append(url)
        }
        if let url = urls.last {
            
            if url.contains(find: "success") {
                
                setupNavButtons()
                let obj = self.storyboard!.instantiateViewController(withIdentifier: "OrderConfirmVC") as! OrderConfirmVC
                self.navigationController!.present(obj, animated: true, completion: nil)
                
            }
            else if url.contains(find: "failed") {
                
                Alert.Show(title: NSLocalizedString("Payment failed", comment: "") , mesage: NSLocalizedString("please enter right credit card", comment: ""), viewcontroller: self)
            }
        }
    }


    



}

extension GatwayVC {

    func setupNavButtons() {


        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.title = NSLocalizedString("Order Saved" , comment: "") 


        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backAction))

        navigationItem.leftBarButtonItem = backButton

        navigationController?.navigationBar.setNeedsLayout()
    }

    @objc func backAction()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeVC = storyboard.instantiateViewController(withIdentifier: "NewHomeVC") as! HomeVC

        self.navigationController?.pushViewController(homeVC, animated: true)

    }

}
