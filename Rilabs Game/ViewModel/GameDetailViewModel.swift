//
//  GameDetailViewModel.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation

class GameDetailViewModel: ObservableObject {
  @Published var game: GameDetailResponse?
  @Published var isLoading: Bool = false
  @Published var error: Error?
  
  private let gameService: GameService
  
  init(gameService: GameService = GameStore.shared) {
    self.gameService = gameService
  }
  
  func loadGame(id: Int) {
    self.game = nil
    self.isLoading = true
    
    gameService.fetchGame(id: id) { [weak self] (result) in
      guard let self = self else { return }
      
      self.isLoading = false
      switch result {
      case .success(let response):
        self.game = response
      case .failure(let error):
        self.error = error
      }
    }
  }
}
