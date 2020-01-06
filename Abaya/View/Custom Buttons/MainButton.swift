//
//  MainButton.swift
//  Abaya
//
//  Created by Kareem Mohammed on 10/5/18.
//  Copyright © 2018 Kareem Mohammed. All rights reserved.
//

import UIKit


class MainButton: UIButton {
    override func imageRect(forContentRect contentRect:CGRect) -> CGRect {
        var imageFrame = super.imageRect(forContentRect: contentRect)
        imageFrame.origin.x = (super.titleRect(forContentRect: contentRect).maxX - imageFrame.width) + 8
        return imageFrame
    }
    
    override func titleRect(forContentRect contentRect:CGRect) -> CGRect {
        var titleFrame = super.titleRect(forContentRect: contentRect)
        if (self.currentImage != nil) {
            titleFrame.origin.x = super.imageRect(forContentRect: contentRect).minX
        }
        return titleFrame
    }
}
