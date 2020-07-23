//
//  FavoriteView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 11/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct FavoriteView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  @FetchRequest(
    entity: Favorite.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \Favorite.name, ascending: false)
    ]
  ) var games: FetchedResults<Favorite>
  @State private var isShowing = false
  
  var body: some View {
    NavigationView {
      if games.isEmpty {
        CustomEmptyView(title: "No Favorite", image: "asset-no-favorite")
          .offset(y: -36)
          .navigationBarTitle("Favorite")
      }
      
      List {
        ForEach(games, id: \.name) { favorite in
          NavigationLink(destination: GameDetailView(game: Game(
            id: Int(favorite.id),
            name: favorite.name ?? "",
            released: favorite.released,
            backgroundImage: favorite.backgroundImage, rating: 0, clip: nil)
          )) {
            FavoriteItemView(favoriteViewModel: FavoriteGameViewModel(favorite: favorite))
          }
        }
        .onDelete(perform: deleteGameFavorite)
      }
      .navigationBarTitle("Favorite")
    }
  }
  
  private func deleteGameFavorite(at offsets: IndexSet) {
    offsets.forEach { index in
      let gameFavorite = self.games[index]
      
      self.managedObjectContext.delete(gameFavorite)
    }
    
    saveContext()
  }
  
  func saveContext() {
    do {
      try managedObjectContext.save()
    } catch {
      print("Error saving managed object context: \(error)")
    }
  }
}
