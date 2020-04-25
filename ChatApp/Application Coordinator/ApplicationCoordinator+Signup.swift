//
//  ApplicationCoordinator+Signup.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import Foundation

extension ApplicationCoordinator: SignupViewControllerDelegate {
    /// When user clicked signin button then display sign in view
    func signUpViewControllerDidTapSignin(_ source: SignUpViewController) {
        displaySigninView()
    }

    /// When user successfully signed up display chat view
    func signUpViewControllerSuccessfullySignedUp(_ source: SignUpViewController) {
        displayChatView()
    }
}
