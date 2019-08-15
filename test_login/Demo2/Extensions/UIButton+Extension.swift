//
//  UIButton+Extension.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setAction(_ action: Selector) {
        addTarget(nil, action: action, for: .touchUpInside)
    }
    
}
