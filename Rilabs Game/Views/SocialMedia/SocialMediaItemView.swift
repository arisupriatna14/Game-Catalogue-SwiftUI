//
//  SocialMediaItemView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 14/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct SocialMediaItemView: View {
  var image: String
  var name: String
  
  var body: some View {
    HStack {
      Image(image)
        .resizable()
        .frame(width: 27, height: 27)
      Text(name)
        .font(.system(size: 18))
    }
  }
}

