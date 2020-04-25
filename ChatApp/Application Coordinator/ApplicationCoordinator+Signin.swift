//
//  ApplicationCoordinator+Signin.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import Foundation

extension ApplicationCoordinator: SignInViewControllerDelegate {
    /// When user successfully signed in display chat view
    func signInViewControllerSuccessfullySignedIn(_ source: SignInViewController) {
        displayChatView()
    }

    /// When user clicked sign up button then display signup page
    func signInViewControllerDidTapSignup(_ source: SignInViewController) {
        displaySignupView()
    }
}
