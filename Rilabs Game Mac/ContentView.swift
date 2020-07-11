//
//  ContentView.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 04/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    RootView()
      .frame(minWidth: 1016, maxWidth: .infinity, minHeight: 556, maxHeight: .infinity)
  }
}

struct RootView: View {
  var body: some View {
    NavigationView {
      NavigationMenuView()
      HomeView()
    }
    .navigationViewStyle(DoubleColumnNavigationViewStyle())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
