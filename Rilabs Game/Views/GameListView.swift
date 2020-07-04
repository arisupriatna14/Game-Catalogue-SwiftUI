//
//  GameListView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct GameListView: View {
  var games: [Game]
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      HeaderView(title: "Trending")

      ForEach(self.games) { game in
        NavigationLink(destination: GameDetailView(game: game)) {
          GameItem(game: game)
        }.buttonStyle(PlainButtonStyle())
      }
    }
  }
}
