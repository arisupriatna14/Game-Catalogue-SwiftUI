//
//  FavoriteItemView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 14/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteItemView: View {
  @ObservedObject var favoriteViewModel: FavoriteGameViewModel
  @State private var opacity: Double = 0.25
  
  var body: some View {
    HStack {
      WebImage(url: URL(string: self.favoriteViewModel.favorite.backgroundImage ?? "")!)
        .resizable()
        .renderingMode(.original)
        .placeholder(content: {
          ShimmerView(opacity: $opacity)
            .frame(width: 100, height: 100)
        })
        .aspectRatio(contentMode: .fill)
        .frame(width: 100, height: 100)
        .cornerRadius(20)
      
      VStack(alignment: .leading) {
        Text("\(favoriteViewModel.favorite.name ?? "")")
          .font(.headline)
        
        RatingView(rating: "\(favoriteViewModel.ratingText)")
        
        Text("\(favoriteViewModel.releaseDateText)")
          .font(.subheadline)
          .padding(.top, 8)
      }
      
      Spacer()
    }
  }
}

