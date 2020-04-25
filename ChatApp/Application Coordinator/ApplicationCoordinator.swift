//
//  ApplicationCoordinator.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/24/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

/// Class for coordinating view controllers and do the navigations
class ApplicationCoordinator: Coordinator {
    /// Declaration of window type `UIWindow`
    let window: UIWindow

    /// Initialize with parameter UIWindow
    /// - Parameter window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }

    /**
     Method being called after initializing,
     it validates user token and determines
     which view controller to show
     - Warning: Make sure to init application coordinator
     with an UIWindow before calling this method.
     - Returns: Void
     */
    func start() {
        if Defaults[\.user] != nil {
            displayChatView()
        } else {
            let onboardingVc = OnboardingViewController()
            onboardingVc.delegate = self
            self.window.rootViewController = onboardingVc
        }
        self.window.makeKeyAndVisible()
    }
}
