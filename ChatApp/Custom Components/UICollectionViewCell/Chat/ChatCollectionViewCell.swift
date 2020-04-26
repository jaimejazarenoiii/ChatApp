//
//  ChatCollectionViewCell.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/26/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import UIKit

/// The main cell for `ChatViewController`'s collectionview
/// contains the message and username
class ChatCollectionViewCell: UICollectionViewCell, ReusableView {
    private var chatView: UIView = UIView()
    private var leftTriangle: UIImageView = UIImageView()
    private var rightTriangle: UIImageView = UIImageView()
    private var chatLabel: UILabel = UILabel()
    private var nameLabel: UILabel = UILabel()

    /// Initialization of custom cell
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }

    func setup(chat: Chat, isRight: Bool) {
        chatLabel.text = chat.message
        nameLabel.text = isRight ? "You" : chat.user.username
        rightTriangle.isHidden = !isRight
        leftTriangle.isHidden = isRight
        nameLabel.textAlignment = isRight ? .right : .left
        chatView.snp.remakeConstraints { make in
            if isRight {
                make.top.equalToSuperview().offset(10)
                make.left.greaterThanOrEqualToSuperview().offset(15)
                make.right.equalToSuperview().offset(-15)
            } else {
                make.top.equalToSuperview().offset(10)
                make.left.equalToSuperview().offset(15)
                make.right.lessThanOrEqualToSuperview().offset(-15)
            }
        }

        nameLabel.addCharacterSpacing()
        chatLabel.addCharacterSpacing()
        chatLabel.setLineSpacing(lineHeightMultiple: 1.2)
    }

    private func setupCell() {
        setupChatView()
        setupChatLabel()
        setupLeftTriangleView()
        setupRightTriangleView()
        setupNameLabel()
    }

    private func setupChatView() {
        chatView.translatesAutoresizingMaskIntoConstraints = false
        chatView.backgroundColor = Asset.Colors.defaultGreen.color
        chatView.layer.cornerRadius = 5

        contentView.addSubview(chatView)

        chatView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.lessThanOrEqualToSuperview().offset(-15)
        }
    }

    private func setupLeftTriangleView() {
        let image = UIImage(systemName: "arrowtriangle.left.fill")!
        leftTriangle.image = image.withRenderingMode(.alwaysTemplate)
        leftTriangle.tintColor = Asset.Colors.defaultGreen.color
        leftTriangle.contentMode = .scaleAspectFill
        contentView.addSubview(leftTriangle)

        leftTriangle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(5)
            make.height.equalTo(15)
            make.bottom.equalTo(chatView).offset(-10)
        }
    }

    private func setupRightTriangleView() {
        let image = UIImage(systemName: "arrowtriangle.right.fill")!
        rightTriangle.image = image.withRenderingMode(.alwaysTemplate)
        rightTriangle.tintColor = Asset.Colors.defaultGreen.color
        rightTriangle.contentMode = .scaleAspectFill
        contentView.addSubview(rightTriangle)

        rightTriangle.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(5)
            make.height.equalTo(15)
            make.bottom.equalTo(chatView).offset(-10)
        }
    }



    private func setupChatLabel() {
        chatLabel.font = .arialFont(size: 14)
        chatLabel.textColor = .white
        chatLabel.numberOfLines = 0
        chatLabel.translatesAutoresizingMaskIntoConstraints = false

        chatView.addSubview(chatLabel)

        chatLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
    }

    private func setupNameLabel() {
        nameLabel.font = .arialFont(size: 10)
        nameLabel.textAlignment = .right
        nameLabel.textColor = Asset.Colors.defaultFormPlaceholderColor.color
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameLabel)

        nameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.top.equalTo(chatView.snp.bottom).offset(5)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
}
