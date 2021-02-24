//
//  HomeView.swift
//  recipe
//
//  Created by mac on 2/15/21.
//

import SwiftUI

struct HomeView: View {
    var homePost: [RecipePost] =
        [
            RecipePost(postingUser: "1", description: "this is a long descriptions. this is a long descriptions. this is a long descriptions.", numberOfLike: 334, image: Image(systemName: "house"), steps: [], ingredients: []),
            RecipePost(postingUser: "2", description: "adsfqi;ojg;agj adsfqi;ojg;agjadsfqi;ojg;agjadsfqi;ojg;agjadsfqi;ojg;agj adsfqi;ojg;agjadsfqi;ojg;agj ", numberOfLike: 123, image: Image(systemName: "house"), steps: [], ingredients: []),
            RecipePost(postingUser: "3", description: "p;flkewquh p;flkewquh p;flkewquhp;flkewquh p;flkewquh  p;flkewquhp;flkewquh p;flkewquh", numberOfLike: 543, image: Image(systemName: "house"), steps: [], ingredients: []),
            RecipePost(postingUser: "4", description: "ijpw;efangvijk ijpw;efangvijk ijpw;efangvijkijpw;efangvijk ijpw;efangvijk ijpw;efangvijk ijpw;efangvijk", numberOfLike: 236, image: Image(systemName: "house"), steps: [], ingredients: [])
        ]
    
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    
                    ForEach(0..<10){ _ in
                        StoryCircleView()
                    }
                }
                .padding()
                .frame(height: 80)
            }
            .background(Color.clear)
            
            ScrollView{
                ForEach(homePost, id: \.id){ p in
                    PostView(post: p)
                }
                
            }
            .background(Color.clear)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
