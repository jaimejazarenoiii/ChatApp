//
//  Chat.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/26/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import Foundation

/// Chat model
struct Chat: Codable {
    var id: String
    var createdAt: Date
    var message: String
    var user: User
}
