//
//  GameItem.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct GameItem: View {
  var game: Game
  @ObservedObject var imageViewModel = ImageViewModel()
  @State private var image: UIImage?
  @State private var opacity: Double = 0.25
  
  var body: some View {
    VStack {
      Group {
        if imageViewModel.image != nil {
          Image(uiImage: imageViewModel.image!)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width - 48, height: 250)
            .cornerRadius(20)
        } else {
          ShimmerView(opacity: $opacity)
            .frame(height: 250)
        }
      }
      
      HStack {
        Text(game.name)
          .font(.headline)
          .bold()
          .foregroundColor(.white)
          .lineLimit(2)
        
        Spacer()
        
        Text("Get".uppercased())
          .font(.headline)
          .bold()
          .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
          .frame(width: 70, height: 30)
          .background(Color.white.opacity(0.5))
          .cornerRadius(15)
      }
      .padding(.top, 16)
      .padding([.leading, .trailing, .bottom], 24)
    }
    .frame(width: UIScreen.main.bounds.width - 48, height: 320)
    .background(imageViewModel.color ?? Color.gray.opacity(0.15))
    .cornerRadius(20)
    .shadow(color: imageViewModel.color?.opacity(0.3) ?? Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
    .padding(8)
    .onAppear {
      if !(self.imageViewModel.image != nil) {
        self.imageViewModel.loadImage(with: self.game.backgroundImageURL)
      }
    }
  }
}
