//
//  CustomImageView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct CustomImageView: View {
  
  @ObservedObject var imageViewModel = ImageViewModel()
  var gameImageURL: URL
  
  var body: some View {
    VStack {
      if imageViewModel.image != nil {
        Image(uiImage: imageViewModel.image!)
          .resizable()
      } else {
        Rectangle()
          .fill(Color.blue.opacity(0.2))
          .cornerRadius(20)
      }
    }
    .onAppear {
      self.imageViewModel.loadImage(with: self.gameImageURL)
    }
  }
}
