//
//  ChatViewController+CollectionView.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/26/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import SwiftyUserDefaults
import UIKit

extension ChatViewController: UICollectionViewDataSource {
    /// returns number of chats from viewModel
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.outputs.chats.value.count
    }

    /// Setups collection view cell
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ChatCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        let chat = self.viewModel.outputs.chats.value[indexPath.row]
        let isRight = chat.user.username == (Defaults[\.user]?.username ?? "")
        cell.setup(chat: chat, isRight: isRight)
        return cell
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    /// Calculates collection view cell's height
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let chat = self.viewModel.outputs.chats.value[indexPath.row]
        let width = view.frame.width
        let size = CGSize(width: width, height: 1000)
        let attributes = [NSAttributedString.Key.font: UIFont.arialFont(size: 14)!]
        let estimatedFrame = NSString(string: chat.message)
            .boundingRect(with: size,
                          options: .usesLineFragmentOrigin,
                          attributes: attributes,
                          context: nil)
        return CGSize(width: view.frame.width, height: estimatedFrame.height + 50)
    }
}
