//
//  SearchItemView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchItemView: View {
  var game: Game
  var size: CGSize = CGSize(width: 100, height: 100)
  @State private var opacity: Double = 0.25
  
  var body: some View {
    HStack {
      WebImage(url: self.game.backgroundImageURL)
        .resizable()
        .renderingMode(.original)
        .placeholder(content: {
          ShimmerView(opacity: $opacity)
            .frame(width: size.width, height: size.height)
        })
        .aspectRatio(contentMode: .fill)
        .frame(width: size.width, height: size.height)
        .cornerRadius(20)
      
      VStack(alignment: .leading) {
        Text(game.name)
          .font(.headline)
          .lineLimit(2)
        
        RatingView(rating: "\(game.ratingText)")
        
        Text(game.releaseDateText)
          .font(.subheadline)
          .padding(.top, 8)
      }
      
      Spacer()
    }
  }
}
