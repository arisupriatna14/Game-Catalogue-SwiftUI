//
//  AddNewGameView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 14/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct AddNewGameView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  
  @State private var showImagePicker = false
  @State private var showAlert = false
  @State private var alertMessage = ""
  @State private var inputImage: UIImage?
  @State private var image: Image?
  
  @State private var titleGame = ""
  @State private var releaseDate = Date()
  @State private var backgroundImage: UIImage?
  @State private var description = ""
  @Binding var isPresented: Bool
  
  let onComplete: (String, String, Date, Data) -> ()
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Title Game")) {
          TextField("Title Games", text: $titleGame)
        }
        
        Section(header: Text("Release Date")) {
          DatePicker(selection: $releaseDate, displayedComponents: .date) {
            Text("Release Date").foregroundColor(.gray)
          }
        }
        
        Section(header: Text("Description Game")) {
          TextField("Description Games", text: $description)
            .lineLimit(5)
        }
        
        Section(header: Text("Image")) {
          HStack {
            Text("Add Image").foregroundColor(.gray)
            Spacer()
            Image(systemName: "tray.and.arrow.up.fill")
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePickerView(image: self.$inputImage)
            }
            .onTapGesture {
              self.showImagePicker.toggle()
            }
          }
          
          if image != nil {
            image?
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: UIScreen.main.bounds.width - 32, height: 200)
              .cornerRadius(20)
          }
        }
      }
    .alert(isPresented: self.$showAlert) {
      Alert(title: Text("Warning"), message: Text(self.alertMessage), dismissButton: .default(Text("OK")))
    }
      .navigationBarTitle("Add New Game", displayMode: .inline)
      .navigationBarItems(
        leading: Button(action: { self.isPresented.toggle() }) {
          Text("Cancel")
        },
        trailing: Button(action: { self.addNewGame() }) {
          Text("Save")
        }
      )
    }
  }
  
  private func loadImage() {
    guard let inputImage = inputImage else { return }
    image = Image(uiImage: inputImage)
    backgroundImage = inputImage
  }
  
  private func addNewGame() {
    if titleGame.isEmpty {
      self.alertMessage = "Title game is required"
      self.showAlert.toggle()
    } else if description.isEmpty {
      self.alertMessage = "Description is required"
      self.showAlert.toggle()
    } else if let backgroundImage = backgroundImage?.pngData() as NSData? {
      self.isPresented.toggle()
      onComplete(
        titleGame,
        description,
        releaseDate,
        backgroundImage as Data
      )
    } else {
      self.alertMessage = "Image is required"
      self.showAlert.toggle()
    }
  }
}
