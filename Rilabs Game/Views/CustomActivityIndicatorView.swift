//
//  CustomActivityIndicatorView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 01/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation
import SwiftUI

struct CustomActivityIndicatorView: UIViewRepresentable {
  func makeUIView(context: Context) -> UIActivityIndicatorView {
    let indicator = UIActivityIndicatorView()
    indicator.style = .medium
    indicator.startAnimating()
    return indicator
  }
  
  func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}
