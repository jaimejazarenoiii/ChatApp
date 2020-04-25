//
//  ChatViewController+View.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import UIKit

extension ChatViewController {
    func setupScene() {
        setupTextViewContainerView()
        setupTextView()
        setupSendButton()
        setupPseudoLine()
        setupCollectionView()
    }

    private func setupTextViewContainerView() {
        textViewContainer.backgroundColor = .white

        view.addSubview(textViewContainer)

        textViewContainer.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeArea.bottom)
        }
    }

    private func setupTextView() {
        textView.backgroundColor = Asset.Colors.defaultFormBackground.color
        textView.layer.cornerRadius = 5
        let color = Asset.Colors.defaultFormPlaceholderColor.color
        let font: UIFont = .arialFont(size: 14)!
        let attrStr = NSAttributedString(string: L10n.startANewMessage,
                                         attributes: [NSAttributedString.Key.foregroundColor: color,
                                                      NSAttributedString.Key.font: font])
        textView.attributedPlaceholder = attrStr
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument,
                                                        to: textView.beginningOfDocument)

        textViewContainer.addSubview(textView)

        textView.snp.makeConstraints { make in
            make.top.bottom.left.equalToSuperview().inset(10)
            make.width.equalToSuperview().offset(-90)
        }
    }

    private func setupSendButton() {
        sendButton.setTitle(L10n.send, for: .normal)
        sendButton.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        sendButton.titleLabel?.addCharacterSpacing()
        sendButton.titleLabel?.adjustsFontSizeToFitWidth = true
        sendButton.backgroundColor = Asset.Colors.defaultGray.color

        textViewContainer.addSubview(sendButton)

        sendButton.snp.makeConstraints { make in
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.left.equalTo(textView.snp.right).offset(10)
            make.right.equalToSuperview().inset(10)
            make.top.greaterThanOrEqualToSuperview().offset(10)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
            make.centerY.equalTo(textView)
        }
    }

    private func setupPseudoLine() {
        pseudoLine.backgroundColor = .black

        view.addSubview(pseudoLine)

        pseudoLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(textViewContainer.snp.top)
            make.height.equalTo(0.4)
        }
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.register(ChatCollectionViewCell.self)
        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(pseudoLine.snp.top)
        }
    }
}
