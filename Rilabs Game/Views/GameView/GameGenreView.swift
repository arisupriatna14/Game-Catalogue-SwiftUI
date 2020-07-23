//
//  GameGenreView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 03/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct GameGenreView: View {
  var genres: [GameGenre]
  var body: some View {
    ForEach(self.genres, id: \.self) { genre in
      GenreText(genre: genre)
    }
  }
}

struct GenreText: View {
  var genre: GameGenre
  var body: some View {
    Text("🎮 \(genre.name)")
  }
}
