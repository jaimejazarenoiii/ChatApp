//
//  User.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import SwiftyUserDefaults

/// User model
struct User: Codable, DefaultsSerializable {
    var id: String
    var createdAt: Date
    var username: String
}
