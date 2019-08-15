//
//  FloatingPlaceholderTextField.swift
//  Demo2
//
//  Created by Vasile Morari on 8/15/19.
//  Copyright © 2019 Vasile Morari. All rights reserved.
//

import UIKit

final class FloatingPlaceholderTextField: UITextField {
    
    // MARK: Inspectable properties
    @IBInspectable var placeHolderColor: UIColor = UIColor.lightGray {
        didSet {
            let attributes = [NSAttributedString.Key.foregroundColor: placeHolderColor]
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
        }
    }
    
    @IBInspectable var underlineColor: UIColor = UIColor.lightGray {
        didSet { underline?.backgroundColor = underlineColor }
    }
    
    // MARK: - Public variables
    var shouldEnableMaterialPlaceHolder: Bool = true
    var isUnderlineAvailabe: Bool = true
    
    var placeholderLabel = UILabel()
    var underline: UIView?
    
    var directionMaterial = PlaceholderState.up
    var difference: CGFloat = 20.0
    var defaultFont = UIFont()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    // MARK: - Overrides
    override public var placeholder: String? {
        willSet {
            let atts = [
                NSAttributedString.Key.foregroundColor.rawValue: UIColor.lightGray,
                NSAttributedString.Key.font: UIFont.labelFontSize
                ] as! [NSAttributedString.Key : Any]
            
            self.attributedPlaceholder = NSAttributedString(string: newValue ?? "", attributes:atts)
            self.enableMaterialPlaceHolder()
        }
        
    }
    
    override public var attributedText:NSAttributedString?  {
        willSet {
            if (self.placeholder != nil) && (self.text != "") {
                let text = NSString(string : self.placeholder!)
                self.setPlaceholderText(text)
            }
        }
    }
    
    @objc func textFieldDidChange() {
        guard shouldEnableMaterialPlaceHolder else { return }
        
        if (self.text == nil) || (self.text?.count)! > 0 {
            self.placeholderLabel.alpha = 1
            self.attributedPlaceholder = nil
            self.placeholderLabel.textColor = self.placeHolderColor
            self.placeholderLabel.frame.origin.x = 0
            let fontSize = self.font!.pointSize;
            self.placeholderLabel.font = UIFont.init(name: (self.font?.fontName)!, size: fontSize - 3)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {() -> Void in
            if (self.text == nil) || (self.text?.count) ?? 0 == 0 {
                self.placeholderLabel.font = self.defaultFont
                self.placeholderLabel.frame = CGRect(x: self.placeholderLabel.frame.origin.x, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            } else {
                if self.directionMaterial == .up {
                    self.placeholderLabel.frame = CGRect(x: self.placeholderLabel.frame.origin.x, y: -self.difference, width: self.frame.size.width, height: self.frame.size.height)
                } else {
                    self.placeholderLabel.frame = CGRect(x: self.placeholderLabel.frame.origin.x, y: self.difference, width: self.frame.size.width, height: self.frame.size.height)
                }
            }
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isUnderlineAvailabe {
            underline?.frame = .init(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        }
    }
    
    override var alignmentRectInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var superBounds = super.rightViewRect(forBounds: bounds)
        superBounds.origin.y -= 8
        return superBounds
    }
}


// MARK: Private API
extension FloatingPlaceholderTextField {
    private func initialize() {
        clipsToBounds = false
        enableMaterialPlaceHolder()
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        if isUnderlineAvailabe {
            addUnderline()
        }
        
        defaultFont = self.font!
    }
    
    private func addUnderline() {
        underline = UIView(frame: .init(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1))
        
        underline?.backgroundColor = .lightGray
        underline?.clipsToBounds = true
        
        self.addSubview(underline!)
    }
    
    private func enableMaterialPlaceHolder() {
        self.placeholderLabel = UILabel()
        self.placeholderLabel.frame = CGRect(x: 0, y : 0, width : 0, height :self.frame.size.height)
        self.placeholderLabel.font = UIFont.systemFont(ofSize: 10)
        self.placeholderLabel.alpha = 0
        self.placeholderLabel.clipsToBounds = true
        self.placeholderLabel.attributedText = self.attributedPlaceholder
        
        self.addSubview(self.placeholderLabel)
    }
    
    private func setPlaceholderText(_ placeholder: NSString) {
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: UIFont.labelFontSize
            ] as [NSAttributedString.Key: Any]
        
        self.attributedPlaceholder = NSAttributedString(string: placeholder as String,
                                                        attributes:attributes)
    }
}

extension FloatingPlaceholderTextField {
    /// Defines state of the floating placeholder
    enum PlaceholderState {
        case up
        case down
    }
}


