//
//  NavigationDetailView.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 05/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct NavigationDetailView: View {
  @State var selection: Game?
  private let gameListViewModel = GameListViewModel()
  
  var body: some View {
    HStack {
      GameListDetailView(gameListViewModel: gameListViewModel, selectedGame: $selection)
        .frame(width: 264)
        .frame(maxHeight: .infinity)
      
      if self.selection != nil {
        GameDetailView(game: selection!)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      } else {
        Text("No selected game")
          .font(.largeTitle)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
    }
  }
}
