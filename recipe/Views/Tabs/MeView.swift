//
//  MeView.swift
//  recipe
//
//  Created by mac on 2/15/21.
//

import SwiftUI

struct MeView: View {
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        ZStack {
            VStack{
                HStack{
                    VStack{
                        Text("\(self.env.currentUser.name)")
                        Text("\(self.env.currentUser.username) ||  \(self.env.currentUser.publishedRecipes.count)")
                    }.padding()
                    
                    Spacer()
                    
                    Image(systemName: "timelapse")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .background(Color.red)
                        .cornerRadius(45)
                        .padding()
                }
                .background(Color.yellow)
                
                HStack{
                    Spacer()
                    Button(action: {}){
                        Text("Follow")
                            .padding(20)
                    }
                    .foregroundColor(.white)
                    .background(darkBlue)
                    .cornerRadius(10)
                    
                    Spacer()
                    
                    Button(action: {}){
                        Text("Message")
                            .padding(20)
                    }
                    .foregroundColor(.black)
                    .background(Color.green)
                    .cornerRadius(10)
                    
                    Spacer()
                }
                
                ScrollView{
                    VStack(spacing: 0) {
                        ForEach(self.env.currentUser.publishedRecipes, id: \.self) { postId in
                            Me_PostView(postId: postId)
                        }
                    }
                }
                .background(Color.red)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
