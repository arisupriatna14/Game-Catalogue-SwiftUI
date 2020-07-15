//
//  StoreGameViewModel.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 14/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation
import SwiftUI

class StoreGameViewModel: ObservableObject {
  @Published var store: Store
  
  init(store: Store) {
    self.store = store
  }
  
  static private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy"
    return formatter
  }()
  
  var releaseDateText: String {
    return StoreGameViewModel.dateFormatter.string(from: store.released ?? Date())
  }
  
  var uiImage: UIImage {
    if let image = UIImage(data: store.backgroundImage!) {
      return image
    }
    return UIImage()
  }
}
