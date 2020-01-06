//
//  LanguageButton.swift
//  Abaya
//
//  Created by Kareem Mohammed on 2/6/18.
//  Copyright © 2018 Kareem Mohammed. All rights reserved.
//

import UIKit

class LanguageButton: UIButton {
    
    var checkMark = UIImageView(image: #imageLiteral(resourceName: "tick_mark"))
    let selectionBgColor = UIColor.colorWithHex("FBFBFB")
    let selectionBorderColor = UIColor.colorWithHex("F6F6F6")
    
    var selectionView = UIView()
    
    
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
//        backgroundColor = UIColor.gray
        setupSelectionView()
        setupCheckMark()

    }
    
    func setupCheckMark() {
        checkMark.alpha = 0.0
        checkMark.layer.masksToBounds = true
        checkMark.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(checkMark)
        
        let tickHeight = NSLayoutConstraint(item: checkMark, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 18)
        let tickWidth = NSLayoutConstraint(item: checkMark, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        let trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: checkMark, attribute: .trailing, multiplier: 1, constant: 10)
        let verticalConstraint = NSLayoutConstraint(item: checkMark, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        
        self.addConstraints([tickWidth, tickHeight, trailing, verticalConstraint])
    }
    
    func setupSelectionView() {
        selectionView.alpha = 0.0
        selectionView.translatesAutoresizingMaskIntoConstraints = false
        selectionView.layer.masksToBounds = true

        selectionView.layer.borderColor = selectionBorderColor.cgColor
        selectionView.backgroundColor = selectionBgColor
        
        self.addSubview(selectionView)
        
        let leading = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: selectionView, attribute: .leading, multiplier: 1, constant: 0)
        
        let top = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: selectionView, attribute: .top, multiplier: 1, constant: 0)
        
        
        let trailing = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: selectionView, attribute: .trailing, multiplier: 1, constant: 0)
        
        let bottom = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: selectionView, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.addConstraints([leading, top, trailing, bottom])
    }
    
    func selectButton(selected: Bool) {
        if selected {
            UIView.animate(withDuration: 0.3, animations: {
                self.selectionView.alpha = 1.0
                self.checkMark.alpha = 1.0
            })
        } else {
            self.selectionView.alpha = 0.0
            self.checkMark.alpha = 0.0
        }
    }
    

}
