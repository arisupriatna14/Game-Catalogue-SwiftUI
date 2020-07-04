//
//  AvatarView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct AvatarView: View {
  @Binding var showProfile: Bool
  
  var body: some View {
    Image("ari")
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: 40, height: 40)
      .clipShape(Circle())
      .sheet(isPresented: $showProfile) {
        ProfileView()
    }
  }
}
