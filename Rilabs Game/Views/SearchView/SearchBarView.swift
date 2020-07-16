//
//  SearchBarView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 02/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct SearchBarView: UIViewRepresentable {
  
  @Binding var text: String
  var placeholder: String
  
  func updateUIView(_ uiView: UISearchBar, context: Context) {
    uiView.text = text
  }
  
  func makeUIView(context: Context) -> UISearchBar {
    let searchBar = UISearchBar(frame: .zero)
    searchBar.placeholder = placeholder
    searchBar.searchBarStyle = .minimal
    searchBar.enablesReturnKeyAutomatically = false
    searchBar.delegate = context.coordinator
    
    return searchBar
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(text: $text)
  }
  
  class Coordinator: NSObject, UISearchBarDelegate {
    @Binding var text: String
    
    init(text: Binding<String>) {
      _text = text
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      self.text = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      searchBar.resignFirstResponder()
    }
  }
}
