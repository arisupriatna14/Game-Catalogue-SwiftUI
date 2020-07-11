//
//  GameDetailView.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 04/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct GameDetailView: View {
  var game: Game
  var showContent = true
  
  @ObservedObject var imageViewModel = ImageViewModel()
  @ObservedObject var gameDetailViewModel = GameDetailViewModel()
  @ObservedObject var gameListScreenshotsViewModelc = GameListScreenshotViewModel()
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      VStack(alignment: .leading) {
        if gameDetailViewModel.game != nil {
          if imageViewModel.image != nil {
            Image(nsImage: imageViewModel.image!)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(height: 280)
          } else {
            Rectangle()
              .fill(Color.gray.opacity(0.2))
              .frame(height: 280)
          }
          
          VStack(alignment: .leading) {
            HStack {
              Text("Rating: ")
                .font(.headline)
              Text("\(gameDetailViewModel.game?.ratingText ?? "-") ⭐️")
            }
            .padding(.bottom, 8)
            
            HStack {
              Text("Release Date: ")
                .font(.headline)
              Text("\(gameDetailViewModel.game?.releaseDateText ?? "-")")
            }
            .padding(.bottom, 8)
            
            VStack(alignment: .leading) {
              Text("Genres: ")
                .font(.headline)
              
              if gameDetailViewModel.game?.genres != nil {
                GameGenreView(genres: self.gameDetailViewModel.game!.genres)
                  .padding(.top, 8)
              }
            }
            .padding(.bottom, 8)
            
            Text("Description")
              .font(.headline)
              .padding(.bottom, 8)
            
            Text("\(gameDetailViewModel.game?.descriptionRaw ?? "-")")
              .padding(.bottom, 8)
          }
          .padding(.top, 16)
          .padding([.leading, .trailing, .bottom], 24)
          
          VStack(alignment: .leading) {
            Text("Screenshots")
              .font(.headline)
              .padding(.bottom, 8)
              .padding(.leading, 24)
            
//            if gameListScreenshotsViewModelc.gameScreenshot != nil {
//              GameListScreenshotView(gameListScreenshots: gameListScreenshotsViewModelc.gameScreenshot!)
//                .padding(.bottom, 16)
//            } else {
//              LoadingView()
//            }
          }
        } else {
          LoadingView()
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .onAppear {
      self.gameDetailViewModel.loadGame(id: self.game.id)
      self.gameListScreenshotsViewModelc.loadGameScreenshots(id: self.game.id)
      self.imageViewModel.loadImage(with: self.game.backgroundImageURL)
    }
  }
}
