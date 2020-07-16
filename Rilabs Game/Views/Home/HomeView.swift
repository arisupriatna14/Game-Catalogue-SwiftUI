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
  @State private var isShowing = false
  
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
        
        if gameViewModel.error != nil {
          CustomEmptyView(title: "No Connection", image: "asset-no-network")
        }
      }
      .navigationBarTitle("Trending")
      .navigationBarHidden(true)
      .onAppear {
        if !(self.gameViewModel.games?.count ?? 0 > 0) {
          self.gameViewModel.loadGames()
        }
      }
    }
  }
}
