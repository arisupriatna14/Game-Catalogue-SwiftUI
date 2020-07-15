//
//  StoreGameView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 14/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct StoreGameView: View {
  @Environment(\.managedObjectContext) var managedObjectContext
  @FetchRequest(
    entity: Store.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \Store.name, ascending: false)
    ]
  ) var stores: FetchedResults<Store>
  @State private var isPresented = false
  
  var body: some View {
    NavigationView {
      if stores.isEmpty {
        CustomEmptyView(title: "Your store is empty", image: "asset-no-data")
          .offset(y: -36)
          .navigationBarTitle("Store")
          .navigationBarItems(
            trailing: Button(action: { self.isPresented.toggle() }) {
              Image(systemName: "plus")
            }
        )
          .sheet(isPresented: $isPresented) {
            AddNewGameView(isPresented: self.$isPresented) { (name, description, releaseDate, image) in
              self.addNewGame(name, description, releaseDate, image)
            }
        }
      }
      List {
        ForEach(stores, id: \.name) { store in
          NavigationLink(destination: StoreDetailView(storeViewModel: StoreGameViewModel(store: store))) {
            StoreItemView(storeViewModel: StoreGameViewModel(store: store))
          }
        }
        .onDelete(perform: deleteGame)
      }
      .sheet(isPresented: $isPresented) {
        AddNewGameView(isPresented: self.$isPresented) { (name, description, releaseDate, image) in
          self.addNewGame(name, description, releaseDate, image)
        }
      }
      .navigationBarTitle("Store")
      .navigationBarItems(
        trailing: Button(action: { self.isPresented.toggle() }) {
          Image(systemName: "plus")
        }
      )
    }
  }
  
  private func deleteGame(at offsets: IndexSet) {
    offsets.forEach { index in
      let game = self.stores[index]
      
      self.managedObjectContext.delete(game)
    }
    
    saveContext()
  }
  
  func saveContext() {
    do {
      try managedObjectContext.save()
    } catch {
      print("Error saving managed object context: \(error)")
    }
  }
  
  private func addNewGame(_ name: String, _ description: String, _ releaseDate: Date, _ imageData: Data) {
    let store = Store(context: managedObjectContext)
    store.id = UUID()
    store.name = name
    store.released = releaseDate
    store.backgroundImage = imageData
    store.descriptions = description
    saveContext()
  }
}

struct StoreItemView: View {
  @ObservedObject var storeViewModel: StoreGameViewModel
  @ObservedObject private var imageViewModel = ImageViewModel()
  @State private var opacity: Double = 0.25
  
  var body: some View {
    HStack {
      Image(uiImage: storeViewModel.uiImage)
      .resizable()
      .aspectRatio(contentMode: .fill)
      .frame(width: 100, height: 100)
      .cornerRadius(20)
      
      VStack(alignment: .leading) {
        Text("\(storeViewModel.store.name ?? "")")
          .font(.headline)
        
        Text("\(storeViewModel.releaseDateText)")
          .font(.subheadline)
          .padding(.top, 8)
      }
      
      Spacer()
    }
  }
}
