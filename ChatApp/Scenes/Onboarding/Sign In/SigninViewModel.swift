//
//  SigninViewModel.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import CodableFirebase
import Firebase
import ReactiveSwift
import Result
import SwiftyUserDefaults

/// Inputs triggered in view controller
protocol SigninViewModelInputs {
    func viewDidLoad()
    func usernameChanged(username: String)
    func passwordChanged(password: String)
    func didSignin()
}

/// available variable / value from this view model
protocol SigninViewModelOutputs {
    var isSuccess: MutableProperty<Bool> { get }
    var isEmailErrHidden: MutableProperty<Bool> { get }
    var isPasswordErrHidden: MutableProperty<Bool> { get }
}

protocol SigninViewModelTypes {
    var inputs: SigninViewModelInputs { get }
    var outputs: SigninViewModelOutputs { get }
}

class SigninViewModel: SigninViewModelTypes, SigninViewModelOutputs, SigninViewModelInputs {
    var inputs: SigninViewModelInputs { return self }
    var outputs: SigninViewModelOutputs { return self }
    var isSuccess: MutableProperty<Bool> = MutableProperty(false)
    var isEmailErrHidden: MutableProperty<Bool> = MutableProperty(true)
    var isPasswordErrHidden: MutableProperty<Bool> = MutableProperty(true)

    init() {
        /// Do the signin action if user passed the validations and tapped the signin button
        /// Checks if there's an existing user for entered details then sign in, else fail
        didSigninProperty.signal.observeValues { [unowned self] _ in
            self.isEmailErrHidden.value = self.userNameChangedProperty.value.isValidLength()
            self.isPasswordErrHidden.value = self.passwordChangedProperty.value.isValidLength()
            let isValid = self.isEmailErrHidden.value && self.isPasswordErrHidden.value
            guard isValid else { return }
            Firestore.firestore().collection("users")
                .whereField("username",
                            isEqualTo: self.userNameChangedProperty.value)
                .whereField("password",
                            isEqualTo: self.passwordChangedProperty.value).getDocuments { snap, err in
                        if err == nil, let snap = snap, snap.documents.count == 1,
                            let document = snap.documents.first {
                            let id = document.documentID
                            let timestamp = document.data()["createdAt"] as? Timestamp
                                ?? Timestamp(date: Date())
                            let user = User(id: id,
                                            createdAt: timestamp.dateValue(),
                                            username: self.userNameChangedProperty.value)
                            Defaults[\.user] = user
                            self.isSuccess.value = err == nil
                        } else {
                            self.isEmailErrHidden.value = false
                            self.isPasswordErrHidden.value = false
                        }
            }
        }
    }

    var viewDidLoadProperty = MutableProperty(())
    func viewDidLoad() {
        viewDidLoadProperty.value = ()
    }

    var userNameChangedProperty = MutableProperty("")
    func usernameChanged(username: String) {
        userNameChangedProperty.value = username
    }

    var passwordChangedProperty = MutableProperty("")
    func passwordChanged(password: String) {
        passwordChangedProperty.value = password
    }

    var didSigninProperty = MutableProperty(())
    func didSignin() {
        didSigninProperty.value = ()
    }
}
