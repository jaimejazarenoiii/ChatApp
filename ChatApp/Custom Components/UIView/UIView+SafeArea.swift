//
//  UIView+SafeArea.swift
//  ChatApp
//
//  Created by Jaime Jazareno III on 4/25/20.
//  Copyright © 2020 Jaime Jazareno III. All rights reserved.
//

import Foundation
import SnapKit

// https://github.com/SnapKit/SnapKit/issues/448#issuecomment-342513599
extension UIView {
  var safeArea: ConstraintBasicAttributesDSL {
    #if swift(>=3.2)
    if #available(iOS 11.0, *) {
      return self.safeAreaLayoutGuide.snp
    }
    #endif
    return self.snp
  }
}
