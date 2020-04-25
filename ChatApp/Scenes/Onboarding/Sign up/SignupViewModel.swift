//
//  SignupViewModel.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import Firebase
import ReactiveSwift
import Result
import SwiftyUserDefaults

/// Inputs triggered in view controller
protocol SignupViewModelInputs {
    func viewDidLoad()
    func usernameChanged(username: String)
    func passwordChanged(password: String)
    func didSignup()
}

/// available variable / value from this view model
protocol SignupViewModelOutputs {
    var isSuccess: MutableProperty<Bool> { get }
    var isEmailErrHidden: MutableProperty<Bool> { get }
    var isPasswordErrHidden: MutableProperty<Bool> { get }
}

protocol SignupViewModelTypes {
    var inputs: SignupViewModelInputs { get }
    var outputs: SignupViewModelOutputs { get }
}

class SignupViewModel: SignupViewModelTypes, SignupViewModelOutputs, SignupViewModelInputs {
    var inputs: SignupViewModelInputs { return self }
    var outputs: SignupViewModelOutputs { return self }
    var isSuccess: MutableProperty<Bool> = MutableProperty(false)
    var isEmailErrHidden: MutableProperty<Bool> = MutableProperty(true)
    var isPasswordErrHidden: MutableProperty<Bool> = MutableProperty(true)

    init() {
        /// Do signup action upon clicking signup button from vc
        /// Checks if user is existing then fail else proceed
        didSignupProperty.signal.observeValues { [unowned self] _ in
            self.isEmailErrHidden.value = self.userNameChangedProperty.value.isValidLength()
            self.isPasswordErrHidden.value = self.passwordChangedProperty.value.isValidLength()
            let isValid = self.isEmailErrHidden.value && self.isPasswordErrHidden.value
            guard isValid else { return }
            Firestore.firestore().collection("users")
                .whereField("username",
                            isEqualTo: self.userNameChangedProperty.value)
                .getDocuments { snap, err in
                        if err == nil, let snap = snap, snap.documents.isEmpty {
                            var ref: DocumentReference? = nil
                            ref = Firestore.firestore().collection("users").addDocument(data: [
                                "createdAt": FieldValue.serverTimestamp(),
                                "username": self.userNameChangedProperty.value,
                                "password": self.passwordChangedProperty.value
                            ]) { err in
                                if err == nil, let ref = ref {
                                    Defaults[\.user] = User(id: ref.documentID,
                                                            createdAt: Date(),
                                                            username: self.userNameChangedProperty.value)
                                    self.isSuccess.value = true
                                }
                            }
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

    var didSignupProperty = MutableProperty(())
    func didSignup() {
        didSignupProperty.value = ()
    }
}
