//
//  FavoriteItemView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 14/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct FavoriteItemView: View {
  var gameFavorite: Favorite
  
  static private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM d, yyyy"
    return formatter
  }()
  
  var releaseDateText: String {
    guard let releaseDate = self.gameFavorite.released, let date = Utils.dateFormatter.date(from: releaseDate) else {
      return "n/a"
    }
    
    return FavoriteItemView.dateFormatter.string(from: date)
  }
  
  @ObservedObject private var imageViewModel = ImageViewModel()
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
        Text("\(gameFavorite.name ?? "")")
          .font(.headline)
        
        Text("\(releaseDateText)")
          .font(.subheadline)
          .padding(.top, 8)
      }
      
      Spacer()
    }
    .onAppear {
      self.imageViewModel.loadImage(with: URL(string: self.gameFavorite.backgroundImage!)!)
    }
  }
}

