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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeVC = storyboard.instantiateViewController(withIdentifier: "NewHomeVC") as! HomeVC
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}


extension CountryViewController {
    
}
