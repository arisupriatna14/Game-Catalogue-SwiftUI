//
//  NavigationMenuView.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 04/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct NavigationMenuView: View {
  @State var selection: String? = "Home"
  
  var body: some View {
    List {
      Section(header: TextHeader(title: "Discover")) {
        NavigationLink(destination: HomeView(), tag: "Home", selection: $selection) {
          Text("Home")
        }
      }
      
      Section(header: TextHeader(title: "Browse")) {
        ForEach(Browse.allCases) { item in
          NavigationLink(destination: NavigationDetailView(), tag: item.rawValue, selection: self.$selection) {
            Text(item.description)
          }
        }
      }
    }
    .listStyle(SidebarListStyle())
    .frame(minWidth: 200, idealWidth: 200, maxWidth: 248, maxHeight: .infinity)
  }
}

struct TextHeader: View {
  var title: String
  
  var body: some View {
    Text(title).font(.system(size: 14))
  }
}

struct NavigationMenuView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationMenuView()
  }
}
