//
//  ApplicationCoordinator+Chat.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/26/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import SwiftyUserDefaults
import UIKit

extension ApplicationCoordinator: ChatViewControllerDelegate {
    /// When user clicked logout button then return to signup page
    func chatViewControllerDidLogout(_ source: ChatViewController) {
        Defaults[\.user] = nil
        displaySignupView()
    }
}
