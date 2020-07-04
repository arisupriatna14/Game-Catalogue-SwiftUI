//
//  BoxView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 03/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct BoxView: View {
  var title: String
  var headline: String
  var subheadline: String
  
  var body: some View {
    VStack {
      Text(title)
        .font(.system(size: 18))
        .foregroundColor(.white)
      
      Text(headline)
        .font(.title)
        .foregroundColor(.white)
        .padding([.top, .bottom], 8)
      
      Text(subheadline)
        .font(.title)
        .foregroundColor(.white)
    }
    .frame(width: UIScreen.main.bounds.width - 48, height: 150)
  }
}

