//
//  GameListView.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 05/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct GameListView: View {
  var games: [Game]
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 24) {
        ForEach(games) { game in
          GameItemView(game: game)
        }
      }
      .padding([.leading, .trailing], 30)
    }
  }
}
