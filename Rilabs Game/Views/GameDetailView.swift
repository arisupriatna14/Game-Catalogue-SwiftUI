//
//  GameDetailView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
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
    ScrollView {
      VStack(alignment: .leading) {
        if gameDetailViewModel.game != nil {
          if gameDetailViewModel.game?.clip != nil {
            VideoPlayerView(url: (gameDetailViewModel.game?.clip?.clips.full)!)
              .frame(height: 280)
          } else if imageViewModel.image != nil {
            Image(uiImage: imageViewModel.image!)
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
            
            if gameListScreenshotsViewModelc.gameScreenshot != nil {
              GameListScreenshotView(gameListScreenshots: gameListScreenshotsViewModelc.gameScreenshot!)
                .padding(.bottom, 16)
            } else {
              LoadingView()
            }
          }
        } else {
          LoadingView()
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .navigationBarTitle(game.name)
    }
    .onAppear {
      self.gameDetailViewModel.loadGame(id: self.game.id)
      self.gameListScreenshotsViewModelc.loadGameScreenshots(id: self.game.id)
      self.imageViewModel.loadImage(with: self.game.backgroundImageURL)
    }
  }
}
