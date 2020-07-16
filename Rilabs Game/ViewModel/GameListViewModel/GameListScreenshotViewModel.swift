//
//  GameListScreenshotViewModel.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 03/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation

class GameListScreenshotViewModel: ObservableObject {
  @Published var gameScreenshot: [GameScreenshot]?
  @Published var isLoading: Bool = false
  @Published var error: Error?
  
  private let gameService: GameService
  
  init(gameService: GameService = GameStore.shared) {
    self.gameService = gameService
  }
  
  func loadGameScreenshots(id: Int) {
    self.gameScreenshot = nil
    self.isLoading = true
    
    gameService.fetchGameScreenshots(id: id) { [weak self] (result) in
      guard let self = self else { return }
      
      self.isLoading = false
      switch result {
      case .success(let response):
        self.gameScreenshot = response.results
      case .failure(let error):
        self.error = error
      }
    }
  }
}
