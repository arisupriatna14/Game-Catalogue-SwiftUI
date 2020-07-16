//
//  StoreDetailView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 14/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct StoreDetailView: View {
  @ObservedObject var storeViewModel: StoreGameViewModel
  
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(alignment: .leading) {
        Image(uiImage: storeViewModel.uiImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(height: 280)
        
        VStack(alignment: .leading) {
          HStack {
            Text("Release Date: ")
              .font(.headline)
            Text("\(storeViewModel.releaseDateText)")
          }
          .padding(.bottom, 8)
          
          Text("Description")
            .font(.headline)
            .padding(.bottom, 8)
          
          Text("\(storeViewModel.store.descriptions ?? "")")
            .padding(.bottom, 8)
        }
        .padding(.top, 16)
        .padding([.leading, .trailing, .bottom], 24)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .navigationBarTitle("\(storeViewModel.store.name ?? "")")
    }
  }
}
