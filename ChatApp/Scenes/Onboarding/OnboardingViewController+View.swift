//
//  OnboardingViewController+View.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import SnapKit
import UIKit

extension OnboardingViewController {
    func setupScene() {
        setupLogo()
        setupSignupButton()
        setupSigninButton()
    }

    private func setupLogo() {
        logo.contentMode = .scaleAspectFit
        logo.image = Asset.Images.logo.image

        view.addSubview(logo)

        logo.snp.makeConstraints { make in
            make.width.equalToSuperview().dividedBy(2)
            make.height.equalTo(logo.snp.width)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-Constants.screenWidth / 3)
            make.top.greaterThanOrEqualToSuperview().offset(10)
        }
    }

    private func setupSignupButton() {
        signUpButton.setTitle(L10n.signUp, for: .normal)
        signUpButton.backgroundColor = Asset.Colors.defaultDarkGreen.color

        view.addSubview(signUpButton)

        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(logo.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }

    private func setupSigninButton() {
        signInButton.setTitle(L10n.logIn, for: .normal)

        view.addSubview(signInButton)

        signInButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }
}
