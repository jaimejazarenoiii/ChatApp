//
//  DefaultTextField.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import UIKit

/// Custom class for textfield, to be used globally
class DefaultTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    /// Alternative initialization without the params frame
    convenience init() {
        self.init(frame: .zero)
        setupTextField()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTextField() {
        backgroundColor = Asset.Colors.defaultFormBackground.color
        autocapitalizationType = .none
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        leftView = paddingView
        leftViewMode = .always
        layer.cornerRadius = 5
    }

    func addCharacterSpacing(kernValue: Double = 1.15) {
        if let labelText = text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedString.Key.kern,
                                          value: kernValue,
                                          range: NSRange(location: 0,
                                                         length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
