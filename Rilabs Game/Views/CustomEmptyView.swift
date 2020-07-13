//
//  SearchNotFound.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 03/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct CustomEmptyView: View {
  var title: String
  var image: String
  
  var body: some View {
    VStack {
      Image(image)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 300, height: 250)
      
      Text(title)
        .font(.system(.title, design: .rounded))
    }
  }
}
