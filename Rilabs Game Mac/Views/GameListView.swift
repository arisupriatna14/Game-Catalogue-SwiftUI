//
//  GameListView.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 05/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct GameListView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  var games: [Game]
  @State private var showModal = false
  @State private var game: Game?
  
  var body: some View {
    ScrollView(.horizontal) {
      HStack(spacing: 24) {
        ForEach(games) { game in
          GameItemView(game: game)
            .onTapGesture {
              self.showModal.toggle()
              self.game = game
          }
        }
      }
      .padding([.leading, .trailing], 30)
      .sheet(isPresented: $showModal) {
        VStack {
          GameDetailView(game: self.game!)
            
          Divider()
          Button(action: { self.showModal.toggle() }) {
            Text("Close")
          }
          .padding(16)
        }
        .frame(minWidth: 1016, maxWidth: .infinity, minHeight: 700, maxHeight: .infinity)
      }
    }
  }
}
