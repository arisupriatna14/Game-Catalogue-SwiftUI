//
//  Game.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 01/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation

struct GameResponse: Decodable {
  let results: [Game]
}

struct Game: Decodable, Identifiable {
  let id: Int
  let name: String
  let released: String?
  let backgroundImage: String
  
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
    
    return Game.dateFormatter.string(from: date)
  }
}

struct FullVideo: Decodable {
  let full: String
}
