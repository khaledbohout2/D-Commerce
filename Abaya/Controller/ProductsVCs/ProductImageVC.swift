//
//  ProductImageVC.swift
//  Blocks
//
//  Created by Khaled Bohout on 3/22/20.
//  Copyright © 2020 Khaled Bohout. All rights reserved.
//

import UIKit
import SDWebImage

class ProductImageVC: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    var imagePath: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScaling()
        setUpImage()
        setupNavButtons()

        // Do any additional setup after loading the view.
    }
    
    func setUpImage() {
        
        let strimgUrl = .imagebaseURL + "products/" + imagePath
        let fileUrl = NSURL(string: strimgUrl)
                        
        imageView.sd_setImage(with: fileUrl! as URL, placeholderImage: UIImage(named: ""),options: SDWebImageOptions(rawValue: 0), completed: { (image, error, cacheType, imageURL) in
                        })
    }
    
    func setUpScaling() {
        
        self.scrollView.delegate = self
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func setupNavButtons() {
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.title = NSLocalizedString("Product Image", comment: "")
        
        let menuButtonItem = UIBarButtonItem(image: UIImage(named: NSLocalizedString("back_arrow", comment: "")), style: .plain, target: self, action: #selector(backAction))
        
        navigationItem.leftBarButtonItem = menuButtonItem
        
        self.navigationController?.navigationBar.tintColor = UIColor.black;

        navigationController?.navigationBar.setNeedsLayout()
        
    }
    
    @objc func backAction()
    {
        
      navigationController?.popViewController(animated: true)

    }
    

}
