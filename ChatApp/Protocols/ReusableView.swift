//
//  ReusableView.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/26/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import UIKit

// https://medium.com
// /@gonzalezreal
// /ios-cell-registration-reusing-with-swift-protocol-extensions-and-generics-c5ac4fb5b75e
// https://medium.com/@gonzalezreal/ios-cell-registration-reusing-with-swift-protocol-extensions-and-generics
protocol ReusableView: class {
  static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
  static var defaultReuseIdentifier: String {
    return String(describing: self)
  }
}

extension UICollectionView {
  func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
    register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
  }

  func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
    guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier,
                                         for: indexPath) as? T else {
                                          fatalError("Dequeue failed: \(T.defaultReuseIdentifier)!")
    }
    return cell
  }
}

extension UITableView {
  func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
    register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
  }

  func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
    guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier,
                                         for: indexPath) as? T else {
                                          fatalError("Dequeue failed: \(T.defaultReuseIdentifier)!")
    }
    return cell
  }
}
