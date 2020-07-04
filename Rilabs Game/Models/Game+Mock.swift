//
//  Game+Mock.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation

extension Game {
  static var mockDataGames: [Game] {
    let responseData: GameResponse? = try? Bundle.main.loadAndDecodeJSON(filename: "game_mock_data.json")
    
    return responseData!.results
  }
  
  static var mockDataGame: Game {
    return mockDataGames[0]
  }
}

extension Bundle {
  func loadAndDecodeJSON<D: Decodable>(filename: String) throws -> D? {
    guard let url = self.url(forResource: filename, withExtension: "json") else {
      return nil
    }
    let data = try Data(contentsOf: url)
    let jsonDecoder = Utils.jsonDecoder
    let decodedModel = try jsonDecoder.decode(D.self, from: data)
    return decodedModel
  }
}
