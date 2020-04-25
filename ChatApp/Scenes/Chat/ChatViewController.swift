//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import IQKeyboardManagerSwift
import UIKit

/// Delegate for `ChatViewController`
protocol ChatViewControllerDelegate: class {
    func chatViewControllerDidLogout(_ source: ChatViewController)
}

/// Main chat view
class ChatViewController: UIViewController {
    let logoutButton: DefaultButton = DefaultButton()
    let textViewContainer: UIView = UIView()
    let textView: IQTextView = IQTextView()
    let sendButton: DefaultButton = DefaultButton()
    let pseudoLine: UIView = UIView()
    let collectionView: UICollectionView
    var viewModel: ChatViewModel
    weak var delegate: ChatViewControllerDelegate?

    init(viewModel: ChatViewModel) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 3
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Upon loadview setup view and subviews
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupScene()
    }

    /// Update navigation bar looks
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let titleLabel = UILabel()
        titleLabel.text = L10n.chatApp
        titleLabel.font = .boldArialFont(size: 18)
        titleLabel.addCharacterSpacing()
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = false
        logoutButton.setTitle(L10n.logOut, for: .normal)
        logoutButton.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        logoutButton.titleLabel?.font = .boldArialFont(size: 12)
        logoutButton.titleLabel?.addCharacterSpacing()
        logoutButton.titleLabel?.adjustsFontSizeToFitWidth = true
        logoutButton.backgroundColor = Asset.Colors.defaultGray.color
        logoutButton.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(30)
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: logoutButton)
    }

    /// Call setupBindings()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    /// Calls `ChatViewModel`'s `viewDidAppear()`
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.inputs.viewDidAppear()
    }

    /// Calls `ChatViewModel`'s `viewDidDisappear()`
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.inputs.viewDidDisappear()
    }

    /// Reactive Bindings
    private func setupBindings() {
        logoutButton.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] _ in
            self.delegate?.chatViewControllerDidLogout(self)
        }
        sendButton.reactive.controlEvents(.touchUpInside).observeValues { [unowned self] _ in
            self.viewModel.inputs.didSend()
            self.textView.text = ""
        }
        textView.reactive.continuousTextValues.skip(while: { $0.isEmpty })
            .observeValues { [unowned self] message in
                self.viewModel.inputs.messageChanged(message: message)
        }
        viewModel.outputs.chats.signal.observeValues { [weak self] comments in
            if let self = `self` {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    let item = self.collectionView(self.collectionView, numberOfItemsInSection: 0) - 1
                    let lastItemIndex = NSIndexPath(item: item, section: 0)
                    self.collectionView.scrollToItem(at: lastItemIndex as IndexPath, at: .top, animated: true)
                }
            }
        }
        viewModel.inputs.viewDidLoad()
    }
}
