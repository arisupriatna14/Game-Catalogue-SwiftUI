//
//  GameListScreenshotView.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 08/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct GameListScreenshotView: View {
  var gameListScreenshots: [GameScreenshot]
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: true) {
      HStack {
        ForEach(gameListScreenshots) { item in
          ImageScreenshotView(gameScreenshot: item)
        }
      }
      .padding([.leading, .trailing], 36)
    }
  }
}

struct ImageScreenshotView: View {
  var gameScreenshot: GameScreenshot
  @ObservedObject var imageViewModel = ImageViewModel()
  
  var body: some View {
    VStack {
      if imageViewModel.image != nil {
        Image(nsImage: imageViewModel.image!)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .frame(width: 300, height: 150)
          .cornerRadius(20)
      } else {
        Rectangle()
          .fill(Color.gray.opacity(0.2))
          .frame(width: 300, height: 150)
          .cornerRadius(20)
      }
    }
    .onAppear {
      self.imageViewModel.loadImage(with: self.gameScreenshot.imageURL)
    }
  }
}
