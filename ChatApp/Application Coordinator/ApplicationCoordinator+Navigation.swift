//
//  ApplicationCoordinator+Navigation.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import UIKit

extension ApplicationCoordinator {
    /// Setups signup vc and displays it
    func displaySignupView() {
        let vm = SignupViewModel()
        let vc = SignUpViewController(viewModel: vm)
        vc.delegate = self
        let navVc = UINavigationController(rootViewController: vc)
        self.window.rootViewController = navVc
        self.window.makeKeyAndVisible()
    }

    /// Setups signin vc and displays it
    func displaySigninView() {
        let vm = SigninViewModel()
        let vc = SignInViewController(viewModel: vm)
        vc.delegate = self
        let navVc = UINavigationController(rootViewController: vc)
        self.window.rootViewController = navVc
        self.window.makeKeyAndVisible()
    }

    /// Setups chat vc and displays it
    func displayChatView() {
        let vm = ChatViewModel()
        let vc = ChatViewController(viewModel: vm)
        vc.delegate = self
        let navVc = UINavigationController(rootViewController: vc)
        self.window.rootViewController = navVc
        self.window.makeKeyAndVisible()
    }
}
