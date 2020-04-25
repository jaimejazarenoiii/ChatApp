//
//  ApplicationCoordinator+Onboarding.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import UIKit

extension ApplicationCoordinator: OnboardingViewControllerDelegate {
    /// When user clicked the signup button, display signup page
    func onboardingViewControllerDidTapSignupButton(_ source: OnboardingViewController) {
        displaySignupView()
    }

    /// When user clicked the signin button, display signin page
    func onboardingViewControllerDidTapSigninButton(_ source: OnboardingViewController) {
        displaySigninView()
    }
}
