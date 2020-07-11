//
//  GameItemRowView.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 05/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct GameItemRowView: View {
  var game: Game
  @ObservedObject private var imageViewModel = ImageViewModel()
  
  var body: some View {
    Group {
      if imageViewModel.image != nil {
        HStack {
          Image(nsImage: imageViewModel.image!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 50)
            .cornerRadius(4)
          
          VStack(alignment: .leading, spacing: 4) {
            Text("\(game.name)")
              .font(.system(size: 14, weight: .medium, design: .rounded))
              .lineLimit(2)
            
            Text("\(game.releaseDateText)")
              .font(.system(size: 12, weight: .light, design: .rounded))
          }
          Spacer()
        }
      } else {
        Rectangle()
          .background(Color.gray.opacity(0.2))
          .frame(width: 100, height: 50)
          .cornerRadius(4)
      }
    }
    .onAppear {
      self.imageViewModel.loadImage(with: self.game.backgroundImageURL)
    }
  }
}
