//
//  String+Validations.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import Foundation

extension String {
    /// Check if length is more than 8 and less than 16
    func isValidLength() -> Bool {
        return self.count >= 8 && self.count <= 16
    }
}
