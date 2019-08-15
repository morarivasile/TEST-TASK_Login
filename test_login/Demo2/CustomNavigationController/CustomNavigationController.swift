//
//  CustomNavigationController.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import UIKit

final class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarAppearance()
        
        self.delegate = self
    }
    
    private func setupNavigationBarAppearance() {
        navigationBar.barTintColor = .white
        navigationBar.titleTextAttributes = [.foregroundColor: #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1),
                                             .font: UIFont.SFUITextSemibold(size: 17)]
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let item = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        item.tintColor = #colorLiteral(red: 0.2901960784, green: 0.5647058824, blue: 0.8862745098, alpha: 1)
        viewController.navigationItem.backBarButtonItem = item
    }
    
}
