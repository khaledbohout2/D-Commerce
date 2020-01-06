//
//  LanguageViewController.swift
//  Abaya
//
//  Created by Khaled Bohout on 10/29/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import MOLH

class LanguageVC: UIViewController {
    
    @IBOutlet weak var engilishButton: LanguageButton!
    
    @IBOutlet weak var arabicButton: LanguageButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBOutlet weak var continueButtonPressed: MainButton!
    


}

extension LanguageVC {
    
    @IBAction func languageAction(_ sender: LanguageButton) {
        
        if sender == arabicButton {
        
            MOLH.setLanguageTo("ar")
            
            if #available(iOS 13.0, *) {
                let delegate = UIApplication.shared.delegate as? AppDelegate
                delegate?.swichRoot()
            } else {
                
            MOLH.reset()
       }
            
            
        } else {
            
            MOLH.setLanguageTo("en")
            
            if #available(iOS 13.0, *) {
            let delegate = UIApplication.shared.delegate as? AppDelegate
                delegate?.swichRoot()
            } else {
                MOLH.reset()
            }

        }
}
}
