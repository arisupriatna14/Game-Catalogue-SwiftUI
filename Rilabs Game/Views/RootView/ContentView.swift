//
//  ContentView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 01/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct TabItem: View {
  var imageName: String
  var title: String
  
  var body: some View {
    VStack {
      Image(systemName: imageName)
      Text(title)
    }
  }
}

struct ContentView: View {
  var body: some View {
    TabView {
      HomeView()
        .tabItem {
          TabItem(imageName: "gamecontroller", title: "Home")
      }
      
      FavoriteView()
        .tabItem {
          TabItem(imageName: "heart.fill", title: "Favorite")
      }
      
      StoreGameView()
        .tabItem {
          TabItem(imageName: "cube.box.fill", title: "Store")
      }
      
      SearchGameView()
        .tabItem {
          TabItem(imageName: "magnifyingglass", title: "Search")
      }
    }
  }
}
