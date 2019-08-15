//
//  ForgotPasswordButtonFactory.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import UIKit

class ForgotPasswordButtonFactory {
    
    static func createButton(_ action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        
        button.setTitle("Забыли пароль?", for: .normal)
        button.frame.size = button.intrinsicContentSize
        button.titleLabel?.font = UIFont.SFUITextRegular(size: 12)
        button.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1).cgColor
        button.setTitleColor(#colorLiteral(red: 0.4745098039, green: 0.4745098039, blue: 0.4745098039, alpha: 1), for: .normal)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4
        button.setAction(action)
        
        return button
    }
}
