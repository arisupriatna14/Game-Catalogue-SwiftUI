//
//  UpcomingGameViewModel.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 23/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation

protocol UpcomingGameViewModelProtocol {
  func loadUpcomingGames()
}

class UpcomingGameViewModel: ObservableObject {
  @Published var games: [Game]?
  @Published var isLoading: Bool = false
  @Published var error: Error?
  
  private let gameService: GameService
  
  init(gameService: GameService = GameStore.shared) {
    self.gameService = gameService
  }
}

extension UpcomingGameViewModel: UpcomingGameViewModelProtocol {
  func loadUpcomingGames() {
    self.games = nil
    self.isLoading = true
    
    gameService.fetchUpcomingGames { [weak self] (result) in
      guard let self = self else { return }
      
      
      self.isLoading = false
      switch result {
      case .success(let response):
        print(response.results)
        self.games = response.results
      case .failure(let error):
        self.error = error
      }
    }
  }
}
