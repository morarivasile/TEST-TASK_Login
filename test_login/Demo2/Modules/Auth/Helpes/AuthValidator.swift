//
//  AuthValidator.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import UIKit

protocol AuthValidatorDelegate: class {
    func areFieldsValid(_ valid: Bool)
}

class AuthValidator: NSObject {
    
    private weak var emailTextField: UITextField?
    private weak var passwordTextField: UITextField?
    
    weak var delegate: AuthValidatorDelegate?
    
    init(emailTextField: UITextField,
         passwordTextField: UITextField,
         delegate: AuthValidatorDelegate?) {
        
        self.delegate = delegate
        self.emailTextField = emailTextField
        self.passwordTextField = passwordTextField
        
        super.init()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func validate(_ input: String?, type: RegexType) -> Bool {
        guard
            let input = input,
            let regex = try? NSRegularExpression(
                pattern: type.regex,
                options: [.caseInsensitive]
            )
            else {
                assertionFailure("Regex not valid")
                return false
        }
        
        let regexFirstMatch = regex
            .firstMatch(in: input,
                        options: [],
                        range: NSRange(location: 0,
                                       length: input.count)
        )
        
        return regexFirstMatch != nil
    }
    
    enum RegexType {
        case email
        case password
        
        var regex: String {
            switch self {
            case .email: return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            case .password: return "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{6,}$"
            }
        }
    }

    
}

// MARK: - UITextFieldDelegate

extension AuthValidator: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var isEmailVaild = validate(emailTextField?.text, type: .email)
        var isPasswordValid = validate(passwordTextField!.text, type: .password)
        
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            if textField == emailTextField {
                isEmailVaild = validate(updatedText, type: .email)
            } else if textField == passwordTextField {
                isPasswordValid = validate(updatedText, type: .password)
            }
        }
        
        delegate?.areFieldsValid(isEmailVaild && isPasswordValid)
        
        return true
    }
    
}

