//
//  GameDetailView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI
import CoreData

struct GameDetailView: View {
  var game: Game
  var showContent: Bool = true
  @State var isFavorite = false
  
  @Environment(\.managedObjectContext) private var managedObjectContext
  @ObservedObject private var imageViewModel = ImageViewModel()
  @ObservedObject private var gameDetailViewModel = GameDetailViewModel()
  @ObservedObject private var gameListScreenshotsViewModel = GameListScreenshotViewModel()
  @State private var opacity: Double = 0.25
  private var favoriteRequest: FetchRequest<Favorite>
  private var gameProvider: GameProvider = GameProvider()
  
  init(game: Game) {
    self.game = game
    self.favoriteRequest = FetchRequest<Favorite>(
      entity: Favorite.entity(),
      sortDescriptors: [NSSortDescriptor(keyPath: \Favorite.name, ascending: true)],
      predicate: NSPredicate(format: "id == \(Int32(self.game.id))")
    )
  }
  
  private func toogleFavorite() {
    if let _ = self.favoriteRequest.wrappedValue.first?.id {
      if !isFavorite {
        isFavorite = true
        addFavorite()
      }
    } else {
      isFavorite = true
      addFavorite()
    }
  }
  
  private func checkStatusFavorite() {
    if let favoriteId = self.favoriteRequest.wrappedValue.first?.id {
      if Int32(game.id) == favoriteId {
        isFavorite = true
      }
    }  else {
      isFavorite = false
    }
  }
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading) {
        if gameDetailViewModel.isLoading {
          LoadingView()
        }
        
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
            ShimmerView(opacity: $opacity)
              .frame(height: 280)
          }
          
          VStack(alignment: .leading) {
            HStack {
              Text("Rating: ")
                .font(.headline)
              Text("\(gameDetailViewModel.game?.ratingText ?? "-") ⭐️")
              Spacer()
              Button(action: toogleFavorite) {
                Image(systemName: "heart.fill")
                  .font(.system(size: 16, weight: .medium))
                  .frame(width: 36, height: 36)
                  .foregroundColor(isFavorite ? Color.pink : Color.gray)
                  .background(Color.white)
                  .clipShape(Circle())
                  .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
                  .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
              }
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
            
            if gameListScreenshotsViewModel.gameScreenshot != nil {
              GameListScreenshotView(gameListScreenshots: gameListScreenshotsViewModel.gameScreenshot!)
                .padding(.bottom, 16)
            } else {
              LoadingView()
            }
          }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .navigationBarTitle(game.name)
    }
    .onAppear {
      self.checkStatusFavorite()
      self.gameDetailViewModel.loadGame(id: self.game.id)
      self.gameListScreenshotsViewModel.loadGameScreenshots(id: self.game.id)
      self.imageViewModel.loadImage(with: self.game.backgroundImageURL)
    }
  }
  
  private func addFavorite() {
    let newFavorite = Favorite(context: managedObjectContext)
    
    newFavorite.id = Int32(game.id)
    newFavorite.name = game.name
    newFavorite.released = game.released
    newFavorite.backgroundImage = game.backgroundImage
    
    saveContext()
  }
  
  private func saveContext() {
    guard managedObjectContext.hasChanges else { return }
    do {
      try managedObjectContext.save()
    } catch {
      print("Error saving managed object context: \(error)")
    }
  }
}
