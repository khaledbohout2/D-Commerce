//
//  ButtonIcon.swift
//  Blocks
//
//  Created by Khaled Bohout on 7/4/20.
//  Copyright © 2020 Khaled Bohout. All rights reserved.
//

import Foundation

//
//  ButtonLeft Icon.swift
//  Link
//
//  Created by Khaled Bohout on 6/9/20.
//  Copyright © 2020 IT PLUS. All rights reserved.
//

import Foundation

@IBDesignable
class RightAlignedIconButton: UIButton {
    
    var language =  Locale.current.languageCode
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if language == "en" {
            
            //semanticContentAttribute = .forceLeftToRight
            contentHorizontalAlignment = .center
       //     let availableSpace = bounds.inset(by: contentEdgeInsets)
//            let availableWidth = availableSpace.width - imageEdgeInsets.right - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -100, bottom: 0, right: 0)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -230)
            
        } else {
        
        //semanticContentAttribute = .forceRightToLeft
        contentHorizontalAlignment = .center
       // let availableSpace = bounds.inset(by: contentEdgeInsets)
       // let availableWidth = availableSpace.width - imageEdgeInsets.left - (imageView?.frame.width ?? 0) - (titleLabel?.frame.width ?? 0)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -100, bottom: 0, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        }
    }
}

