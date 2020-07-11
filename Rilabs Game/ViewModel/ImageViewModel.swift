//
//  ImageViewModel.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 01/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

private let _imageCache = NSCache<AnyObject, AnyObject>()
private let _colorCache = NSCache<AnyObject, AnyObject>()

class ImageViewModel: ObservableObject {
  
  @Published var image: UIImage?
  @Published var isLoading = false
  @Published var color: Color?
  
  var imageCache = _imageCache
  var colorCache = _colorCache
  
  func loadImage(with url: URL) {
    let urlString = url.absoluteString
    
    if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage,
      let colorFromCache = colorCache.object(forKey: urlString as AnyObject) as? Color {
      self.image = imageFromCache
      self.color = colorFromCache
      return
    }
    
    DispatchQueue.global(qos: .background).async { [weak self] in
      guard let self = self else { return }
      
      do {
        let data = try Data(contentsOf: url)
        guard let image = UIImage(data: data) else { return }
        guard let imageColor = UIImage(data: data)?.averageColor else { return }
        
        self.imageCache.setObject(image, forKey: urlString as AnyObject)
        self.colorCache.setObject(imageColor, forKey: urlString as AnyObject)
        
        DispatchQueue.main.async { [weak self] in
          self?.image = image
          self?.color = Color(imageColor)
        }
      } catch {
        print(error.localizedDescription)
      }
    }
  }
}
