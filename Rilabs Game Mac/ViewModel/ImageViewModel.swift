//
//  ImageViewModel.swift
//  Rilabs Game Mac
//
//  Created by Ari Supriatna on 04/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation
import SwiftUI
import AppKit

private let _imageCache = NSCache<AnyObject, AnyObject>()
private let _colorCache = NSCache<AnyObject, AnyObject>()

class ImageViewModel: ObservableObject {
  
  @Published var image: NSImage?
  
  var imageCache = _imageCache
  var colorCache = _colorCache
  
  func loadImage(with url: URL) {
    let urlString = url.absoluteString
    
    if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? NSImage {
      self.image = imageFromCache
      return
    }
    
    DispatchQueue.global(qos: .background).async { [weak self] in
      guard let self = self else { return }
      
      do {
        let data = try Data(contentsOf: url)
        guard let image = NSImage(data: data) else { return }
        
        self.imageCache.setObject(image, forKey: urlString as AnyObject)
        
        DispatchQueue.main.async { [weak self] in
          self?.image = image
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}

