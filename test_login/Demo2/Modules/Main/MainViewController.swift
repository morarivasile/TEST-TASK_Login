//
//  MainViewController.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction private func authButtonTapped(_ sender: Any) {
        let authViewController = AuthViewController.instantiate()
        navigationController?.pushViewController(authViewController, animated: true)
    }
    
}
