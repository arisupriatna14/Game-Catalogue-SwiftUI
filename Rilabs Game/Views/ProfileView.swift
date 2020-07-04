//
//  ProfileView.swift
//  Rilabs Game
//
//  Created by Ari Supriatna on 03/07/20.
//  Copyright © 2020 Ari Supriatna. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
  var body: some View {
    ScrollView {
      VStack {
        HStack {
          Image("ari")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(Circle())
            .frame(width: 100, height: 100)
          
          VStack(alignment: .leading) {
            Text("Ari Supriatna")
              .font(.system(size: 24))
            
            HStack {
              Image(systemName: "star.fill")
              Text("6250 XP")
                .font(.system(size: 18))
            }
          }
          .padding(.leading)
          
          Spacer()
        }
        .padding(24)
        
        BoxView(title: "Belajar", headline: "24", subheadline: "Kelas Akademi")
          .background(Color(#colorLiteral(red: 0.07058823529, green: 0.7725490196, blue: 0.7764705882, alpha: 1)))
          .cornerRadius(20)
          .padding(.bottom, 16)
        
        BoxView(title: "Memenangkan", headline: "2", subheadline: "Challenge")
          .background(Color(#colorLiteral(red: 0.7019607843, green: 0.4705882353, blue: 0.8235294118, alpha: 1)))
          .cornerRadius(20)
          .padding(.bottom, 16)
        
        BoxView(title: "Menghadiri", headline: "16", subheadline: "Event")
          .background(Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)))
          .cornerRadius(20)
          .padding(.bottom, 16)
        
        Spacer()
      }
    }
  }
}
