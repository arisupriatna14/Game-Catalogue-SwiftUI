//
//  ImagePickerView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 14/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
  @Environment(\.presentationMode) var presentationMode
  @Binding var image: UIImage?
  
  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
    let picker = UIImagePickerController()
    picker.delegate = context.coordinator
    return picker
  }
  
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    
  }
  
  class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    let parent: ImagePickerView
    
    init(_ parent: ImagePickerView) {
      self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      if let uiImage = info[.originalImage] as? UIImage {
        parent.image = uiImage
      }
      
      parent.presentationMode.wrappedValue.dismiss()
    }
  }
  
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
}
