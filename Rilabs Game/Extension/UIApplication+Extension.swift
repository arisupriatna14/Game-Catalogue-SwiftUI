//
//  UIApplication+Extension.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 03/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
  func endEditing(_ force: Bool) {
    self.windows
      .filter { $0.isKeyWindow }
      .first?
      .endEditing(force)
  }
}
