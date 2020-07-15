//
//  SearchGameViewModel.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation
import Combine

class SearchGameViewModel: ObservableObject {
  @Published var query = ""
  @Published var games: [Game]?
  @Published var isLoading: Bool = false
  @Published var error: Error?
  
  private let gameService: GameService
  private var subscriptionToken: AnyCancellable?
  
  var isEmptyResult: Bool {
    return !self.query.isEmpty && self.games != nil && self.games!.isEmpty
  }
  
  init(gameService: GameService = GameStore.shared) {
    self.gameService = gameService
  }
  
  deinit {
    self.subscriptionToken?.cancel()
    self.subscriptionToken = nil
  }
  
  func startObserve() {
    guard subscriptionToken == nil else { return }
    
    self.subscriptionToken = self.$query.map { [weak self] text in
      self?.games = nil
      self?.error = nil
      
      return text
    }
    .throttle(for: 1, scheduler: DispatchQueue.main, latest: true)
    .sink { [weak self] in self?.search(query: $0)}
  }
  
  func search(query: String) {
    self.games = nil
    self.isLoading = false
    
    guard !query.isEmpty else { return }
    
    self.isLoading = true
    gameService.searchGame(query: query) { [weak self] (result) in
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
