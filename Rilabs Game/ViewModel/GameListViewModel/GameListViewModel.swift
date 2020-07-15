//
//  GameListViewModel.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 01/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation

class GameListViewModel: ObservableObject {
  @Published var games: [Game]?
  @Published var isLoading: Bool = false
  @Published var error: Error?
  
  private let gameService: GameService
  
  init(gameService: GameService = GameStore.shared) {
    self.gameService = gameService
  }
  
  func loadGames() {
    self.games = nil
    self.isLoading = true
    
    gameService.fetchGames { [weak self] (result) in
      guard let self = self else { return }
      
      self.isLoading = false
      switch result {
      case .success(let response):
        self.games = response.results
      case .failure(let error):
        self.error = error
      }
    }
  }
}
