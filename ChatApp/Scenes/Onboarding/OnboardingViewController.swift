//
//  OnboardingViewController.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/24/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import ReactiveCocoa
import UIKit

/// Delegate for `OnboardingViewController`
protocol OnboardingViewControllerDelegate: class {
    func onboardingViewControllerDidTapSignupButton(_ source: OnboardingViewController)
    func onboardingViewControllerDidTapSigninButton(_ source: OnboardingViewController)
}

/// Onboarding view
class OnboardingViewController: UIViewController {
    var logo: UIImageView = UIImageView()
    var signUpButton: DefaultButton = DefaultButton()
    var signInButton: DefaultButton = DefaultButton()
    weak var delegate: OnboardingViewControllerDelegate?

    /// Setup view and subviews
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupScene()
    }

    /// Setup bindings
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    /// Setup reactive bindings
    private func setupBindings() {
        signUpButton.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] _ in
            self.delegate?.onboardingViewControllerDidTapSignupButton(self)
        }
        signInButton.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] _ in
            self.delegate?.onboardingViewControllerDidTapSigninButton(self)
        }
    }
}
