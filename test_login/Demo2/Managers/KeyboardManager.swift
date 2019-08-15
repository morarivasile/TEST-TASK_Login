//
//  KeyboardManager.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import UIKit

/// Manages keyboard height appearance
class KeyboardManager {
    
    private weak var mainView: UIView?
    private weak var visibleView: UIView?
    
    init(mainView: UIView?, visibleView: UIView?) {
        self.mainView = mainView
        self.visibleView = visibleView
    }
    
    func startObserving() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInsetForKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInsetForKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func adjustInsetForKeyboard(_ notification: NSNotification) {
        guard let mainView = mainView, let visibleView = visibleView else { return }
        
        let userInfo = notification.userInfo!
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let show = (notification.name == UIResponder.keyboardWillShowNotification) ? true : false
        
        let adjustmentHeight = keyboardFrame.height * (show ? 1 : -1)
        
        let bottomHeight = mainView.frame.height - (visibleView.frame.origin.y + visibleView.frame.height + 16)
        
        if bottomHeight < adjustmentHeight {
            mainView.frame.origin.y = -(adjustmentHeight - bottomHeight)
        } else {
            mainView.frame.origin.y = 0
        }
    }
    
}
