//
//  HomeView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var gameViewModel = GameListViewModel()
  
  init() {
    self.gameViewModel.loadGames()
  }
  
  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        HeaderView(title: "Trending")
        
        if gameViewModel.isLoading {
          LoadingView()
        }
        
        if gameViewModel.games != nil {
          ForEach(self.gameViewModel.games!) { game in
            NavigationLink(destination: GameDetailView(game: game)) {
              GameItem(game: game)
            }.buttonStyle(PlainButtonStyle())
          }
        }
      }
      .navigationBarTitle("Trending")
      .navigationBarHidden(true)
    }
  }
}
