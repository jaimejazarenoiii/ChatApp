//
//  SignInViewController.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import UIKit

/// Delegate for `SignInViewController`
protocol SignInViewControllerDelegate: class {
    func signInViewControllerSuccessfullySignedIn(_ source: SignInViewController)
    func signInViewControllerDidTapSignup(_ source: SignInViewController)
}

/// Signin view
class SignInViewController: UIViewController {
    var usernameTextField: DefaultTextField = DefaultTextField()
    var usernameErrLabel: UILabel = UILabel()
    var passwordTextField: DefaultTextField = DefaultTextField()
    var passwordErrLabel: UILabel = UILabel()
    var signUpButton: DefaultButton = DefaultButton()
    var loginButton: DefaultButton = DefaultButton()
    var termsLabel: UILabel = UILabel()
    var viewModel: SigninViewModel
    weak var delegate: SignInViewControllerDelegate?

    init(viewModel: SigninViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Setup view and subviews
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupScene()
    }

    /// Setup navigation bar looks
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let titleLabel = UILabel()
        titleLabel.text = L10n.chatApp
        titleLabel.font = .boldArialFont(size: 18)
        titleLabel.addCharacterSpacing()
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = false
    }

    /// Setup bindings
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    /// Setup reactive bindings
    private func setupBindings() {
        viewModel.outputs.isSuccess.signal.observeValues { [weak self] isSuccess in
            if let self = `self` {
                self.usernameErrLabel.isHidden = !isSuccess
                self.passwordErrLabel.isHidden = !isSuccess
                guard isSuccess else { return }
                self.delegate?.signInViewControllerSuccessfullySignedIn(self)
            }
        }

        viewModel.outputs.isPasswordErrHidden.signal.observeValues { [weak self] isHidden in
            if let self = `self` {
                self.passwordErrLabel.isHidden = isHidden
            }
        }

        viewModel.outputs.isEmailErrHidden.signal.observeValues { [weak self] isHidden in
            if let self = `self` {
                self.usernameErrLabel.isHidden = isHidden
            }
        }

        usernameTextField.reactive.continuousTextValues.skip(while: { $0.isEmpty })
            .observeValues { email in
                self.viewModel.inputs.usernameChanged(username: email)
        }

        passwordTextField.reactive.continuousTextValues.skip(while: { $0.isEmpty })
            .observeValues { password in
                self.viewModel.inputs.passwordChanged(password: password)
        }

        loginButton.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] _ in
            self.viewModel.inputs.didSignin()
        }

        signUpButton.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] _ in
            self.delegate?.signInViewControllerDidTapSignup(self)
        }

        viewModel.inputs.viewDidLoad()
    }
}
