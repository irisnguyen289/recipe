//
//  PostView.swift
//  recipe
//
//  Created by mac on 2/15/21.
//

import SwiftUI

struct PostView: View {
    var post: RecipePost
    
    var body: some View {
        VStack(spacing: 0){
            self.post.image
                .frame(height: 300)
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
                .background(Color.init(red: 0.95, green: 0.95, blue: 0.95).opacity(0.8))
            
            HStack{
                VStack(alignment: .leading){
                    Text("Prep time: \(self.post.prepTime) \(self.post.prepTimeUnit.rawValue)")
                    Text("Cook time: \(self.post.cookTime) \(self.post.cookTimeUnit.rawValue)")
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(self.post.ingredients.count) ingredients")
                    Text("\(self.post.steps.count) steps")
                }
            }
            .font(.system(size: 15, weight: .bold))
            .foregroundColor(Color.init(red: 230/255, green: 105/255, blue: 50/255))
            .padding(.top, 5)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            
            VStack{
                HStack{
                    Image(systemName: "heart")
                    Text("\(self.post.numberOfLike)")
                    Image(systemName: "envelope")
                    Spacer()
                    Image(systemName: "bookmark")
                }
                
                HStack{
                    Text("\(self.post.postingUser)")
                        .font(.system(size: 17, weight: .bold))
                    Spacer()
                }
                
                HStack{
                    Text("\(self.post.description)")
                        .font(.system(size: 17, weight: .regular))
                    Spacer()
                    
                }
            }
            .padding(10)
            .padding(.top, 0)
            .background(Color.clear)
        }
        .background(Color.clear)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView(post: RecipePost(
                    postingUser: "user",
                    description: "This is a description",
                    numberOfLike: 3,
                    image: Image(systemName: "heart.fill"),
                    steps: [],
                    ingredients: []))
    }
}
