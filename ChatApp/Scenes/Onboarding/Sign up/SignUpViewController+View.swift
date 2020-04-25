//
//  SignUpViewController+View.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import UIKit

extension SignUpViewController {
    func setupScene() {
        setupUsernameTextField()
        setupUsernameErrLabel()
        setupPasswordTextField()
        setupPasswordErrLabel()
        setupSignUpButton()
        setupLoginButton()
        setupTermsLabel()
    }

    private func setupUsernameTextField() {
        let color = Asset.Colors.defaultFormPlaceholderColor.color
        let font: UIFont = UIFont.arialFont(size: 14)!
        let attrStr = NSAttributedString(string: L10n.username,
                                         attributes: [NSAttributedString.Key.foregroundColor: color,
                                                      NSAttributedString.Key.font: font])
        usernameTextField.attributedPlaceholder = attrStr
        usernameTextField.addCharacterSpacing()
        usernameTextField.font = font

        view.addSubview(usernameTextField)

        usernameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }

    private func setupUsernameErrLabel() {
        usernameErrLabel.textColor = Asset.Colors.defaultRed.color
        usernameErrLabel.text = L10n.valueIsIncorrect
        usernameErrLabel.font = .arialFont(size: 14)
        usernameErrLabel.isHidden = true

        view.addSubview(usernameErrLabel)

        usernameErrLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
            make.left.right.equalTo(usernameTextField).inset(5)
        }
    }

    private func setupPasswordTextField() {
        let color = Asset.Colors.defaultFormPlaceholderColor.color
        let font: UIFont = UIFont.arialFont(size: 14)!
        let attrStr = NSAttributedString(string: L10n.password,
                                         attributes: [NSAttributedString.Key.foregroundColor: color,
                                                      NSAttributedString.Key.font: font])
        passwordTextField.attributedPlaceholder = attrStr
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addCharacterSpacing()
        passwordTextField.font = font

        view.addSubview(passwordTextField)

        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameErrLabel.snp.bottom).offset(10)
            make.left.right.equalTo(usernameTextField)
            make.height.equalTo(50)
        }
    }

    private func setupPasswordErrLabel() {
        passwordErrLabel.textColor = Asset.Colors.defaultRed.color
        passwordErrLabel.text = L10n.valueIsIncorrect
        passwordErrLabel.font = .arialFont(size: 14)
        passwordErrLabel.isHidden = true

        view.addSubview(passwordErrLabel)

        passwordErrLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(10)
            make.left.right.equalTo(usernameTextField).inset(5)
        }
    }

    private func setupSignUpButton() {
        signUpButton.setTitle(L10n.signUp, for: .normal)

        view.addSubview(signUpButton)

        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordErrLabel.snp.bottom).offset(20)
            make.left.right.equalTo(usernameTextField)
            make.height.equalTo(50)
        }
    }

    private func setupLoginButton() {
        let attrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.foregroundColor: Asset.Colors.defaultFormPlaceholderColor.color,
        ]
        let attrStr = NSAttributedString(string: L10n.logIn, attributes: attrs)
        loginButton.setAttributedTitle(attrStr, for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.titleLabel?.font = .arialFont(size: 14)
        loginButton.backgroundColor = .clear

        view.addSubview(loginButton)

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
            make.left.right.equalTo(usernameTextField)
        }
    }

    private func setupTermsLabel() {
        termsLabel.font = .arialFont(size: 12)
        termsLabel.text = L10n.terms
        termsLabel.addCharacterSpacing()
        termsLabel.numberOfLines = 0
        termsLabel.textColor = Asset.Colors.defaultFormPlaceholderColor.color

        view.addSubview(termsLabel)

        termsLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.left.right.equalTo(usernameTextField)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }
}
