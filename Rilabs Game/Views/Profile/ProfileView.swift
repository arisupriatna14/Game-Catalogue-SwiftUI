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
      VStack(alignment: .leading) {
        HStack {
          Image("ari")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80, height: 80)
            .cornerRadius(20)
          
          VStack(alignment: .leading) {
            Text("Ari Supriatna")
              .font(.system(size: 24))
              .bold()
            
            SocialMediaItemView(image: "apple", name: "iOS Developer")
          }
          .padding(.leading)
          
          Spacer()
        }
        .padding(24)
        
        VStack(alignment: .leading) {
          SocialMediaItemView(image: "instagram", name: "@arisupriatna1408")
          SocialMediaItemView(image: "gmail", name: "arisupriatna703@gmail.com")
          SocialMediaItemView(image: "linkedin", name: "Ari Supriatna")
          Divider()
            .padding(.top, 16)
        }
        .padding([.leading, .trailing], 24)
        
        VStack(alignment: .leading) {
          Text("About Me")
            .font(.system(size: 18, weight: .medium, design: .rounded))
            .bold()
          
          Text("I currently live in Jakarta, I come from Banten. I graduated from the department of higher education in 2017. I am interested in programming and this has been a hobby since I was in high school, I learned self-taught programming. After I graduated from high school, I joined Bootcamp Hacktiv8 to learn programming. Besides liking programming, I also like the challenges and new things about technology. My current expertise is ExpressJs, Nodejs, Vuejs, ReactJs, React Native, MongoDB, AWS, Google Cloud Platform, etc. ")
            .padding(.top, 16)
        }
        .padding([.leading, .trailing], 24)
        
        Spacer()
      }
    }
  }
}
