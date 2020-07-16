//
//  GameItem.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct GameItem: View {
  var game: Game
  @State private var image: UIImage?
  @State private var opacity: Double = 0.25
  
  var body: some View {
    VStack {
      WebImage(url: self.game.backgroundImageURL)
        .resizable()
        .renderingMode(.original)
        .placeholder(content: {
          ShimmerView(opacity: $opacity)
            .frame(height: 250)
        })
        .aspectRatio(contentMode: .fill)
        .frame(width: UIScreen.main.bounds.width - 48, height: 250)
        .cornerRadius(20)
      
      HStack {
        VStack(alignment: .leading) {
          Text(game.name)
            .font(.headline)
            .bold()
            .foregroundColor(.white)
            .lineLimit(2)
          
          Text(game.releaseDateText)
            .font(.caption)
            .foregroundColor(.white)
        }
        
        Spacer()
        
        RatingView(rating: "\(game.ratingText)")
          .frame(width: 90, height: 40)
          .background(Color.white.opacity(0.5))
          .cornerRadius(20)
      }
      .padding(.top, 16)
      .padding([.leading, .trailing, .bottom], 24)
    }
    .frame(width: UIScreen.main.bounds.width - 48, height: 320)
    .background(Color(#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)))
    .cornerRadius(20)
    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
    .padding(8)
  }
}
