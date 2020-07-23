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
    .background(Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)))
    .cornerRadius(20)
    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
    .padding(8)
  }
}

struct GameItemHorizontal: View {
  var game: Game
  @State private var opacity: Double = 0.25
  
  var body: some View {
    VStack(alignment: .leading) {
      Group {
        if game.clip?.clips != nil {
          VideoPlayerView(url: (game.clip?.clips.full)!)
            .frame(width: UIScreen.main.bounds.width / 1.2, height: 200)
            .cornerRadius(10)
        } else {
          WebImage(url: self.game.backgroundImageURL)
            .resizable()
            .renderingMode(.original)
            .placeholder(content: {
              ShimmerView(opacity: $opacity)
                .frame(height: 150)
            })
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width / 1.2, height: 200)
            .cornerRadius(20)
        }
      }
      
      NavigationLink(destination: GameDetailView(game: game)) {
        HStack(alignment: .center) {
          WebImage(url: self.game.backgroundImageURL)
            .resizable()
            .renderingMode(.original)
            .placeholder(content: {
              ShimmerView(opacity: $opacity)
                .frame(width: 60, height: 60)
            })
            .aspectRatio(contentMode: .fill)
            .frame(width: 60, height: 60)
            .cornerRadius(10)
          
          VStack(alignment: .leading) {
            Text(game.name)
              .font(.headline)
              .bold()
              .lineLimit(2)
            
            Text(game.releaseDateText)
              .font(.caption)
          }
          
          Spacer()
          
          RatingView(rating: "\(game.ratingText)")
            .frame(width: 90, height: 40)
            .background(Color.white.opacity(0.5))
            .cornerRadius(20)
        }
        .padding(.top, 8)
      }
      .buttonStyle(PlainButtonStyle())
    }
    .padding(.trailing, 8)
  }
}
