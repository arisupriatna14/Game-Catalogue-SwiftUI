//
//  SearchItemView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct SearchItemView: View {
  var game: Game
  @ObservedObject var imageViewModel = ImageViewModel()
  @State private var opacity: Double = 0.25
  
  var body: some View {
    HStack {
      if imageViewModel.image != nil {
        Image(uiImage: imageViewModel.image!)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 100, height: 100)
          .cornerRadius(20)
      } else {
        ShimmerView(opacity: $opacity)
          .frame(width: 100, height: 100)
      }
      
      VStack(alignment: .leading) {
        Text(game.name)
          .font(.headline)
        
        Text(game.releaseDateText)
          .font(.subheadline)
          .padding(.top, 8)
      }
      
      Spacer()
    }
    .padding([.leading, .trailing, .bottom], 16)
    .onAppear {
      self.imageViewModel.loadImage(with: self.game.backgroundImageURL)
    }
  }
}
