//
//  LoadingView.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 04/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
  var body: some View {
    VStack(alignment: .center) {
      CustomActivityIndicatorView()
      
      Text("Loading".uppercased())
        .font(.caption)
        .fontWeight(.light)
    }
  }
}

struct LoadingView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingView()
  }
}
