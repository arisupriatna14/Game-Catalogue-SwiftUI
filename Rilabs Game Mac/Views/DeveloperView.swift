//
//  DeveloperView.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 04/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct DeveloperView: View {
  let title: String
  
  var body: some View {
    VStack {
      Text(title)
        .font(.title)
        .bold()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
