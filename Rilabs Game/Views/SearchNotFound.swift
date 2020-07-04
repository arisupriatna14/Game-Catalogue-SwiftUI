//
//  SearchNotFound.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 03/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct SearchNotFound: View {
  var body: some View {
    VStack {
      Image("asset-search")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 300, height: 250)
      
      Text("No Result")
        .font(.title)
        .bold()
    }
  }
}
