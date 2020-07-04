//
//  GameService.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 01/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation

protocol GameService {
  func fetchGames(completion: @escaping (Result<GameResponse, GameError>) -> ())
  func fetchGame(id: Int, completion: @escaping (Result<GameDetailResponse, GameError>) -> ())
  func searchGame(query: String, completion: @escaping (Result<GameResponse, GameError>) -> ())
  func fetchGameScreenshots(id: Int, completion: @escaping (Result<GameScreenshotResponse, GameError>) -> ())
}

enum GameError: Error {
  case apiError
  case noData
  case invalidEndpoint
}
