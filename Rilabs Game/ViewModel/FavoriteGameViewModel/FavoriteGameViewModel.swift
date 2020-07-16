//
//  FavoriteGameViewModel.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 14/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation

class FavoriteGameViewModel: ObservableObject {
  @Published var favorite: Favorite
  
  init(favorite: Favorite) {
    self.favorite = favorite
  }
  
  static private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy"
    return formatter
  }()
  
  var releaseDateText: String {
    guard let releaseDate = self.favorite.released, let date = Utils.dateFormatter.date(from: releaseDate) else {
      return "n/a"
    }
    
    return FavoriteGameViewModel.dateFormatter.string(from: date)
  }
  
  var ratingText: String {
    return String(favorite.rating)
  }
}
