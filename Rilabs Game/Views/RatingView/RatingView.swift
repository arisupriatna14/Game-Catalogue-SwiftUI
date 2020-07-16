//
//  RatingView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 14/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct RatingView: View {
  var rating: String
  
  var body: some View {
    HStack {
      Image(systemName: "star.fill")
        .foregroundColor(.yellow)
      Text(rating)
        .font(.headline)
        .bold()
        .foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
    }
  }
}
