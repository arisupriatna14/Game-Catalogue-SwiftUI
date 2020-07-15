//
//  GameListScreenshotView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 03/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct GameListScreenshotView: View {
  var gameListScreenshots: [GameScreenshot]
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(gameListScreenshots) { item in
          ImageScreenshotView(gameScreenshot: item)
        }
      }
      .padding([.leading, .trailing], 24)
    }
  }
}

struct ImageScreenshotView: View {
  var gameScreenshot: GameScreenshot
  @ObservedObject var imageViewModel = ImageViewModel()
  @State private var opacity: Double = 0.25
  
  var body: some View {
    VStack {
      if imageViewModel.image != nil {
        Image(uiImage: imageViewModel.image!)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 300, height: 150)
          .cornerRadius(20)
      } else {
        ShimmerView(opacity: $opacity)
          .frame(width: 300, height: 150)
      }
    }
    .onAppear {
      self.imageViewModel.loadImage(with: self.gameScreenshot.imageURL)
    }
  }
}
