//
//  CustomActivityIndicator.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 04/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct CustomActivityIndicatorView: NSViewRepresentable {
  func makeNSView(context: Context) -> NSProgressIndicator {
    let indicator = NSProgressIndicator()
    indicator.style = .spinning
    indicator.startAnimation(nil)
    return indicator
  }
  
  func updateNSView(_ uiView: NSProgressIndicator, context: Context) {}
}
