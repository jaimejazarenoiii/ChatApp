//
//  ChatViewModel.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import Firebase
import ReactiveCocoa
import ReactiveSwift
import Result
import SwiftyUserDefaults

/// Inputs triggered in view controller
protocol ChatViewModelInputs {
    func messageChanged(message: String)
    func viewDidLoad()
    func viewDidAppear()
    func viewDidDisappear()
    func didSend()
}

/// available variable / value from this view model
protocol ChatViewModelOutputs {
    var chats: MutableProperty<[Chat]> { get }
    var sendBtnIsEnabled: MutableProperty<Bool> { get }
}

protocol ChatViewModelTypes {
    var inputs: ChatViewModelInputs { get }
    var outputs: ChatViewModelOutputs { get }
}

class ChatViewModel: ChatViewModelTypes, ChatViewModelInputs, ChatViewModelOutputs {
    var sendBtnIsEnabled: MutableProperty<Bool> = MutableProperty(false)
    var inputs: ChatViewModelInputs { return self }
    var outputs: ChatViewModelOutputs { return self }

    var viewDidLoadProperty = MutableProperty(())
    func viewDidLoad() {
        viewDidLoadProperty.value = ()
    }

    var viewDidAppearProperty = MutableProperty(())
    func viewDidAppear() {
        viewDidAppearProperty.value = ()
    }

    var viewDidDisappearProperty = MutableProperty(())
    func viewDidDisappear() {
        viewDidDisappearProperty.value = ()
    }

    var messageChangedProperty = MutableProperty("")
    func messageChanged(message: String) {
        messageChangedProperty.value = message
    }

    var didSendProperty = MutableProperty(())
    func didSend() {
        didSendProperty.value = ()
    }

    var chats: MutableProperty<[Chat]>
    private var listener: ListenerRegistration?

    init() {
        chats = MutableProperty([])
        /// get all chats if view did appear
        viewDidAppearProperty.signal.signal.observeValues { _ in
            self.getChats()
        }
        /// cancel listener if view did disappear
        viewDidDisappearProperty.signal.observeValues { _ in
            guard let listener = self.listener else { return }
            listener.remove()
        }

        /// Disables button if empty message
        messageChangedProperty.signal.observeValues { message in
            self.sendBtnIsEnabled.value = message.isEmpty
        }

        /// Triggers send to firebase if message is not emtpy
        didSendProperty.signal.observeValues { _ in
            guard !self.messageChangedProperty.value.isEmpty,
                let currentUser = Defaults[\.user] else { return }
            Firestore.firestore().collection("chats").addDocument(data: [
                "message": self.messageChangedProperty.value,
                "createdAt": Timestamp(date: Date()),
                "user": Firestore.firestore().collection("users").document(currentUser.id)
            ])
        }
    }

    /// gets all chats from firestore
    func getChats() {
        listener = Firestore.firestore().collection("chats")
            .addSnapshotListener { snap, err in
            guard err == nil, let snap = snap else { return }
                var tmpArray: [Chat] = []
                var index = 0
                snap.documents.forEach { document in
                    let message = document.data()["message"] as? String ?? ""
                    let tmpDocRef = document.data()["user"] as? DocumentReference
                    let chatCreatedAt = document.data()["createdAt"] as? Timestamp ?? Timestamp(date: Date())
                    guard let docRef = tmpDocRef else { return }
                    docRef.getDocument(completion: { userSnaps, err in
                        guard err == nil, let userSnap = userSnaps else { return }
                        let username = userSnap.data()?["username"] as? String ?? ""
                        let createdAt = userSnap.data()?["createdAt"] as? Timestamp ??
                            Timestamp(date: Date())
                        let date = createdAt.dateValue()
                        let user = User(id: userSnap.documentID, createdAt: date, username: username)
                        let comment = Chat(id: document.documentID,
                                           createdAt: chatCreatedAt.dateValue(),
                                           message: message,
                                           user: user)
                        index += 1
                        tmpArray.append(comment)
                        if index + 1 == snap.documents.count {
                            self.chats.value = tmpArray.sorted(by: { $0.createdAt < $1.createdAt })
                        }
                    })
                }
        }
    }
}
