//
//  FilterVC.swift
//  Abaya
//
//  Created by Khaled Bohout on 11/30/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import RangeSeekSlider

class FilterVC: UIViewController {
    
    @IBOutlet weak var bestSellerButtonOutlet: UIButton!
    
    @IBOutlet weak var priceButtonOutlet: UIButton!
    
    @IBOutlet weak var highToLowOutlet: UIButton!
    
    @IBOutlet weak var lowToHighOutlet: UIButton!
    
    @IBOutlet weak var filterSlider: RangeSeekSlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backBySwipe()
        
        highToLowOutlet.isUserInteractionEnabled = false
        lowToHighOutlet.isUserInteractionEnabled = false
        highToLowOutlet.isHidden = true
        lowToHighOutlet.isHidden = true
    
    }
    
    func backBySwipe() {
        
        let gesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss(fromGesture:)))
        self.view.addGestureRecognizer(gesture)
    }
    

    @objc func dismiss(fromGesture gesture: UISwipeGestureRecognizer) {

        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func closeButtonClicked(_ sender: Any) {

        
    }
    
    @IBAction func bestsellerbuttonclicked(_ sender: Any) {
        
        if bestSellerButtonOutlet.isSelected {
            
            highToLowOutlet.isUserInteractionEnabled = false
            lowToHighOutlet.isUserInteractionEnabled = false
            highToLowOutlet.isHidden = true
            lowToHighOutlet.isHidden = true

            bestSellerButtonOutlet.isSelected = false
            
            let notTickedImg = UIImage(named: "ic_radio_button_unchecked")
            
              bestSellerButtonOutlet.setImage(notTickedImg, for: UIControl.State.normal)

        } else {
            
            bestSellerButtonOutlet.isSelected = true
            
            highToLowOutlet.isUserInteractionEnabled = true
            highToLowOutlet.isHidden = false
            lowToHighOutlet.isHidden = false
            lowToHighOutlet.isUserInteractionEnabled = true
            
            let tickedImg = UIImage(named: "tick_mark.png")
            
            bestSellerButtonOutlet.setImage(tickedImg, for: UIControl.State.normal)
  
        }
    }
    
    @IBAction func priceButtonClicked(_ sender: Any) {
        

              if priceButtonOutlet.isSelected {
                  
                  priceButtonOutlet.isSelected = false
                  
                  let notTickedImg = UIImage(named: "ic_radio_button_unchecked")
                    priceButtonOutlet.setImage(notTickedImg, for: UIControl.State.normal)

              } else {
                  
                  priceButtonOutlet.isSelected = true
                  
                  let tickedImg = UIImage(named: "tick_mark.png")
                  priceButtonOutlet.setImage(tickedImg, for: UIControl.State.normal)
        
              }

        
        
    }
    @IBAction func highToLowButtonClicked(_ sender: Any) {
        
        orderByNew = "asc"

        lowToHighOutlet.isSelected = false
        highToLowOutlet.backgroundColor = UIColor.black
        highToLowOutlet.setTitleColor(UIColor.white, for: .normal)
        lowToHighOutlet.backgroundColor = UIColor.white
        lowToHighOutlet.setTitleColor(UIColor.black, for: .normal)

        
    }
    
    @IBAction func lowToHighButtonClicked(_ sender: Any) {
        
        orderByNew = "desc"
        
        highToLowOutlet.isSelected = false
        lowToHighOutlet.backgroundColor = UIColor.black
        lowToHighOutlet.setTitleColor(UIColor.white, for: .normal)
        highToLowOutlet.backgroundColor = UIColor.white
        highToLowOutlet.setTitleColor(UIColor.black, for: .normal)
        
    }
    
    @IBAction func applyButtonPressed(_ sender: Any) {
        

        
        let minPriceint = Int(filterSlider.selectedMinValue)

        minPrice = String(minPriceint)
        
        let maxPriceint = Int(filterSlider.selectedMaxValue)

        maxPrice = String(maxPriceint)
        
        productToFilter = ""

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchResultsVC") as! SearchResultsVC
        self.navigationController?.pushViewController(vc, animated: true)

        
    }


}


