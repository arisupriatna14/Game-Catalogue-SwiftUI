//
//  GameDetail.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 03/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation

struct GameDetailResponse: Decodable, Identifiable {
  let id: Int
  let name: String
  let descriptionRaw: String
  let released: String?
  let genres: [GameGenre]
  let clip: GameClip?
  let backgroundImage: String
  let rating: Double
  
  var backgroundImageURL: URL {
    return URL(string: backgroundImage)!
  }
  
  static private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy"
    return formatter
  }()
  
  var releaseDateText: String {
    guard let releaseDate = self.released, let date = Utils.dateFormatter.date(from: releaseDate) else {
      return "n/a"
    }
    
    return GameDetailResponse.dateFormatter.string(from: date)
  }
  
  var ratingText: String {
    return String(rating)
  }
}

struct GameClip: Decodable {
  let clips: FullVideo
}

struct GameGenre: Decodable, Hashable {
  let id: Int
  let name: String
}
