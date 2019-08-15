//
//  UIAlertController+Extension.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func present(from view: UIViewController, title: String?, message: String?, actions: [CustomActions]) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { ac.addAction($0.action) }
        view.present(ac, animated: true, completion: nil)
    }
    
    enum CustomActions {
        typealias handler = () -> Void
        
        case ok(handler: handler?)
        case cancel(handler: handler?)
        
        var action: UIAlertAction {
            switch self {
            case .ok(let actionHandler):
                return UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    if let actionHandler = actionHandler {
                        actionHandler()
                    }
                })
            case .cancel(let actionHandler):
                return UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                    if let actionHandler = actionHandler {
                        actionHandler()
                    }
                })
            }
        }
    }
    
}
