//
//  Browse.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 04/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation

enum Browse: String, CaseIterable, Identifiable {
  var id: String { rawValue }
  
  case developer
  case topStar
  case store
  case platform
  
  var description: String {
    switch self {
      case .developer: return "Developer"
      case .topStar: return "Top Star"
      case .store: return "Store"
      case .platform: return "Platform"
    }
  }
}
