//
//  DefaultKeys.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import SwiftyUserDefaults

/// Declaration of custom keys
extension DefaultsKeys {
    var user: DefaultsKey<User?> { .init("user") }
}
