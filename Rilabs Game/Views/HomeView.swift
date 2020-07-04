//
//  HomeView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject private var gameViewModel = GameListViewModel()
  
  var body: some View {
    NavigationView {
      ScrollView {
        HeaderView(title: "Trending")
        
        if gameViewModel.games != nil {
          ForEach(self.gameViewModel.games!) { game in
            NavigationLink(destination: GameDetailView(game: game)) {
              GameItem(game: game)
            }.buttonStyle(PlainButtonStyle())
          }
        } else {
          LoadingView()
        }
      }
      .navigationBarTitle("Trending")
      .navigationBarHidden(true)
      .onAppear {
        self.gameViewModel.loadGames()
      }
    }
  }
}
