//
//  HomeView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
  @ObservedObject private var gameViewModel = GameListViewModel()
  @ObservedObject private var upcomingGameViewModel = UpcomingGameViewModel()
  @State private var isShowing = false
  @State private var opacity = 0.25
  
  var body: some View {
    NavigationView {
      ScrollView(.vertical) {
        HeaderView(title: "Popular")
        
        Group {
          if upcomingGameViewModel.isLoading {
            ScrollView(.horizontal, showsIndicators: false) {
              HStack {
                ForEach(0..<3) { index in
                  ShimmerView(opacity: self.$opacity)
                    .frame(width: UIScreen.main.bounds.width / 1.5, height: 150)
                    .padding(8)
                }
              }
              .padding([.trailing, .leading], 24)
            }
          } else if upcomingGameViewModel.games != nil {
            ScrollView(.horizontal, showsIndicators: false) {
              HStack {
                ForEach(self.upcomingGameViewModel.games!) { game in
                  GameItemHorizontal(game: game)
                }
              }
              .padding([.trailing, .leading], 20)
            }
          }
        }
        
//        Divider()
//        
//        WebImage(url: URL(string: "https://media.rawg.io/media/games/1eb/1ebef06e55f756974654c35b9aedb127.jpg")!)
//          .resizable()
//          .renderingMode(.original)
//          .placeholder(content: {
//            ShimmerView(opacity: $opacity)
//              .frame(height: 250)
//          })
//          .aspectRatio(contentMode: .fit)
        
        Group {
          if gameViewModel.isLoading {
            ForEach(0..<3) { index in
              ShimmerView(opacity: self.$opacity)
                .frame(width: UIScreen.main.bounds.width - 48, height: 320)
                .padding(8)
            }
          } else if gameViewModel.games != nil {
            VStack(alignment: .leading) {
              Text("What We're Playing")
                .font(.system(size: 24, weight: .semibold, design: .rounded))
              
              ForEach(self.gameViewModel.games!) { game in
                NavigationLink(destination: GameDetailView(game: game)) {
                  SearchItemView(game: game, size: CGSize(width: 130, height: 130))
                }.buttonStyle(PlainButtonStyle())
              }
            }
            .padding(20)
          }
        }
        
        if gameViewModel.error != nil || upcomingGameViewModel.error != nil {
          CustomEmptyView(title: "No Connection", image: "asset-no-network")
        }
      }
      .navigationBarTitle("Trending")
      .navigationBarHidden(true)
      .onAppear {
        if !(self.gameViewModel.games?.count ?? 0 > 0) {
          self.gameViewModel.loadGames()
          self.upcomingGameViewModel.loadUpcomingGames()
        }
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
  }
}
