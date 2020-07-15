//
//  LoadingView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 01/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
  var body: some View {
    VStack {
      CustomActivityIndicatorView()
      
      Text("Loading".uppercased())
        .font(.caption)
        .fontWeight(.light)
    }
  }
}
