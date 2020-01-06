//
//  CountryViewController.swift
//  Abaya
//
//  Created by Kareem Mohammed on 2/9/18.
//  Copyright © 2018 Kareem Mohammed. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    @IBOutlet weak var kuwaitButton: LanguageButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        kuwaitButton.selectButton(selected: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }

    @IBAction func btnHomeAction(_ sender: Any)
    {
        
        let homeVC = HomeVC(nibName: "productDetail", bundle: nil)
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}


extension CountryViewController {
    
}
