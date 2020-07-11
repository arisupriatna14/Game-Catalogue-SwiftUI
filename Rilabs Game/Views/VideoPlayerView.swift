//
//  VideoPlayerView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 03/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI
import AVKit

struct VideoPlayerView: UIViewControllerRepresentable {
  var url: String
  
  func makeUIViewController(context: Context) -> AVPlayerViewController {
    let controller = AVPlayerViewController()
    let player = AVPlayer(url: URL(string: url)!)
    controller.player = player
    controller.videoGravity = .resize
    return controller
  }
  
  func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
}
