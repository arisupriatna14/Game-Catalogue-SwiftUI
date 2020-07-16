//
//  GameListScreenshotView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 03/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

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
      WebImage(url: self.gameScreenshot.imageURL)
        .resizable()
        .renderingMode(.original)
        .placeholder(content: {
          ShimmerView(opacity: $opacity)
            .frame(width: 300, height: 150)
        })
        .aspectRatio(contentMode: .fill)
        .frame(width: 300, height: 150)
        .cornerRadius(20)
    }
  }
}
