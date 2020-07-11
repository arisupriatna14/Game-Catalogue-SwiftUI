//
//  HomeView.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 04/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject private var gameListViewModel = GameListViewModel()
  
  var body: some View {
    ScrollView {
      VStack(alignment: .leading) {
        if gameListViewModel.games != nil {
          VStack(alignment: .leading) {
            Text("Trending")
              .font(.title)
              .bold()
              .padding([.leading, .top], 30)
            Divider()
              .padding([.leading, .trailing, .bottom], 30)
            GameListView(games: gameListViewModel.games!)
            Spacer()
          }
          
          VStack(alignment: .leading) {
            Text("Popular")
              .font(.title)
              .bold()
              .padding([.leading, .top], 30)
            Divider()
              .padding([.leading, .trailing, .bottom], 30)
            GameListView(games: gameListViewModel.games!)
            Spacer()
          }
          
          VStack(alignment: .leading) {
            Text("Top Rated")
              .font(.title)
              .bold()
              .padding([.leading, .top], 30)
            Divider()
              .padding([.leading, .trailing, .bottom], 30)
            GameListView(games: gameListViewModel.games!)
            Spacer()
          }
        } else {
          LoadingView()
        }
      }
      .padding(.bottom, 30)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .onAppear {
        self.gameListViewModel.loadGames()
      }
    }
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
