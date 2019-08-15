//
//  AuthViewController.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//


import UIKit
import CoreLocation

class AuthViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var passwordTextField: FloatingPlaceholderTextField!
    @IBOutlet weak var emailTextField: FloatingPlaceholderTextField!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - Private variables
    private let locationManager = CLLocationManager()
    private let client = WeatherClient()
    
    private var keybaordManager: KeyboardManager!
    private var validator: AuthValidator!
    
    // MARK: - View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Авторизация"
        
        initHelpers()
        setupPasswordTextField()
        setupCreateAccountButton()
        hideKeyboardWhenTappedAround()
        keybaordManager.startObserving()
        
        locationManager.requestWhenInUseAuthorization()
    }
    
}

// MARK: - Private

extension AuthViewController {
    
    private func initHelpers() {
        keybaordManager = KeyboardManager(mainView: view,
                                          visibleView: createAccountButton)
        
        validator = AuthValidator(emailTextField: emailTextField,
                                  passwordTextField: passwordTextField,
                                  delegate: self)
    }
    
    private func setupCreateAccountButton() {
        createAccountButton.setAction(#selector(onCreateAccountButtonTapped))
    }
    
    private func setupPasswordTextField() {
        let forgotPasswordButton = ForgotPasswordButtonFactory
            .createButton(#selector(onForgotPasswordButtonTapped))
        
        passwordTextField.rightView = forgotPasswordButton
        passwordTextField.rightViewMode = .always
    }
    
}

// MARK: - Private selectors

extension AuthViewController {
    
    @IBAction private func onLoginButtonTapped(_ sender: Any) {
        guard let coordinates = locationManager.location?.coordinate else {
            self.presentInfoAlert(with: "Maybe you should turn on location first?!")
            return
        }
        
        self.loginButton.isEnabled = false
        
        client.getData(with: .forecast(latitude: coordinates.latitude, longitude: coordinates.longitude)) { (result: Result<WeatherModel, APIError>) in
            
            if case .success(let weatherModel) = result {
                self.presentWeatherAlert(with: weatherModel.daily.summary)
            } else if case .failure(let error) = result {
                self.presentWeatherAlert(with: error.description)
            }
            
            self.loginButton.isEnabled = true
        }
    }
    
    @objc private func onForgotPasswordButtonTapped() {
        presentInfoAlert(with: "Forgot password? Looser!")
    }
    
    @objc private func onCreateAccountButtonTapped() {
        presentInfoAlert(with: "Don't have an account? Huh..")
    }
    
}

// MARK: - Alert presentation

extension AuthViewController {
    
    private func presentWeatherAlert(with summary: String) {
        UIAlertController.present(from: self, title: "Result", message: summary, actions: [.ok(handler: nil)])
    }
    
    private func presentInfoAlert(with text: String?) {
        UIAlertController.present(from: self, title: "Info", message: text, actions: [.ok(handler: nil)])
    }
    
}

// MARK: - AuthValidatorDelegate

extension AuthViewController: AuthValidatorDelegate {
    
    func areFieldsValid(_ valid: Bool) {
        loginButton.isEnabled = valid
    }
    
}
