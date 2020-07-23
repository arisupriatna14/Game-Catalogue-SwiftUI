//
//  GameItemView.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 05/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct GameItemView: View {
  var game: Game
  @ObservedObject private var imageViewModel = ImageViewModel()
  @State private var opacity = 0.25
  
  var body: some View {
    Group {
      if imageViewModel.image != nil {
        VStack(alignment: .leading) {
          Image(nsImage: imageViewModel.image!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 300, height: 250)
            .cornerRadius(30)
          
          Text("\(game.name)")
            .font(.headline)
            .bold()
            .lineLimit(2)
            .frame(width: 300, alignment: .leading)
          
          Text("\(game.releaseDateText)")
            .font(.system(size: 16, weight: .light, design: .rounded))
        }
      } else {
        ShimmerView(opacity: $opacity)
          .frame(width: 300, height: 250)
      }
    }
    .onAppear {
      self.imageViewModel.loadImage(with: self.game.backgroundImageURL)
    }
  }
}
