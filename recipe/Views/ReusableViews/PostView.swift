//
//  PostView.swift
//  recipe
//
//  Created by mac on 2/15/21.
//

import SwiftUI

struct PostView: View {
    var postingUser: String
    var description: String
    var numberOfLike: Int
    var image: Image
    
    var body: some View {
        VStack{
            image
                .frame(height: 300)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                .background(Color.init(red: 0.95, green: 0.95, blue: 0.95).opacity(0.8))
            
            VStack{
                HStack{
                    Image(systemName: "heart")
                    Text("\(numberOfLike)")
                    Image(systemName: "envelope")
                    Spacer()
                    Image(systemName: "bookmark")
                }
                
                HStack{
                    Text("\(postingUser)")
                        .font(.system(size: 14, weight: .bold))
                    Spacer()
                }
                
                HStack{
                    Text("\(description)")
                        .font(.system(size: 14, weight: .regular))
                    Spacer()
                    
                }
            }
            .padding()
            .background(Color.clear)
        }
        .background(Color.clear)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(postingUser: "user", description: "This is a description", numberOfLike: 3, image: Image(systemName: "heart.fill"))
    }
}
