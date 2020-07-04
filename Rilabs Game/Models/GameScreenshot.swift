//
//  GameScreenshot.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 03/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation

struct GameScreenshotResponse: Decodable {
  let results: [GameScreenshot]?
}

struct GameScreenshot: Decodable, Identifiable {
  let id: Int
  let image: String
  
  var imageURL: URL {
    return URL(string: image)!
  }
}
