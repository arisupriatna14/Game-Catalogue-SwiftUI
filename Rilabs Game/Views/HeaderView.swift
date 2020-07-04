//
//  HeaderView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
  var title: String
  @State var showProfile = false
  
  var body: some View {
    HStack {
      Text(title)
        .font(.largeTitle)
        .bold()
      
      Spacer()
      
      AvatarView(showProfile: $showProfile)
        .onTapGesture {
          self.showProfile.toggle()
      }
    }
    .padding(.top, 24)
    .padding([.leading, .trailing], 24)
  }
}
