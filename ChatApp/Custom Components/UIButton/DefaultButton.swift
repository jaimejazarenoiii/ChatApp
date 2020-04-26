//
//  DefaultButton.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import UIKit

/// Custom class for UIButton, to be used globally
class DefaultButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    /// Alternative initialization without the params frame
    convenience init() {
        self.init(type: .system)
        setupButton()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Setups button's attributes
    private func setupButton() {
        backgroundColor = Asset.Colors.defaultGreen.color
        titleLabel?.font = .boldArialFont(size: 20)
        tintColor = .white
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 5.0
    }

    func enabled() {
        setupButton()
        isEnabled = true
    }

    func disabled() {
        isEnabled = false
    }
}
