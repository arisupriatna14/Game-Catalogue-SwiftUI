//
//  GameListDetailView.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 05/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct GameListDetailView: View {
  @ObservedObject var gameListViewModel: GameListViewModel
  @Binding var selectedGame: Game?
  
  var body: some View {
    ZStack {
      if gameListViewModel.isLoading {
        LoadingView()
        .zIndex(1)
      }
      
      List(selection: self.$selectedGame) {
        if self.gameListViewModel.games != nil {
          ForEach(self.gameListViewModel.games!) { game in
            GameItemRowView(game: game)
              .tag(game)
          }
        }
      }
    }
    .onAppear {
      self.gameListViewModel.loadGames()
    }
  }
}
