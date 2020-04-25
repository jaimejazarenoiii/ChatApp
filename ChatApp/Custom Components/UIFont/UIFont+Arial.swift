//
//  UIFont+Arial.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import UIKit

extension UIFont {
    /// Custom static func for setting arial font
    static func arialFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "ArialMT", size: size)
    }

    /// Custom static func for setting bold arial font
    static func boldArialFont(size: CGFloat) -> UIFont? {
        return UIFont(name: "Arial-BoldMT", size: size)
    }
}
