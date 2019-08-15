//
//  UIFont+Extension.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import UIKit

@objc extension UIFont {
    
    // MARK: SFUIText
    
    static func SFUITextLight(size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Light", size: size)!
    }
    
    static func SFUITextRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Regular", size: size)!
    }
    
    static func SFUITextSemibold(size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Semibold", size: size)!
    }
    
    static func SFUITextBold(size: CGFloat) -> UIFont {
        return UIFont(name: "SFUIText-Bold", size: size)!
    }
    
}

