//
//  SearchGameView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct SearchGameView: View {
  @ObservedObject var searchGameViewModel = SearchGameViewModel()
  @State var text = ""
  
  var body: some View {
    NavigationView {
      ScrollView(.vertical, showsIndicators: false) {
        HeaderView(title: "Search")
        
        SearchBarView(
          text: self.$searchGameViewModel.query,
          placeholder: "Search your favorite games"
        )
          .offset(y: -16)
          .padding([.leading, .trailing], 16)
        
        if searchGameViewModel.isLoading {
          LoadingView()
        } else if searchGameViewModel.isEmptyResult {
          SearchNotFound()
          Spacer()
        }
        
        if searchGameViewModel.games != nil {
          ForEach(searchGameViewModel.games!) { game in
            NavigationLink(destination: GameDetailView(game: game)) {
              SearchItemView(game: game)
            }
            .buttonStyle(PlainButtonStyle())
          }
        }
        
        Spacer()
      }
      .navigationBarTitle("Search")
      .navigationBarHidden(true)
      .onAppear {
        self.searchGameViewModel.startObserve()
      }
      .gesture(DragGesture().onChanged({ _ in
          UIApplication.shared.endEditing(true)
        })
      )
    }
  }
}
