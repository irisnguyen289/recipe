//
//  Me_PostView.swift
//  recipe
//
//  Created by mac on 3/31/21.
//

import SwiftUI
import Firebase
import FirebaseStorage

struct Me_PostView: View {
    var postId: String
    @State var post = RecipePost.init(
        postingUser: "",
        description: "",
        numberOfLike: 0,
        images: [],
        title: "",
        steps: [],
        ingredients: [],
        prepTime: 1, prepTimeUnit: .min, cookTime: 1, cookTimeUnit: .min)
    
    @State var postSize: CGFloat = UIScreen.main.bounds.width / 4
    @State var picSize: CGFloat = UIScreen.main.bounds.width / 5
    
    var body: some View {
        ZStack{
            Image(systemName: "timelapse")
                .resizable()
                .scaledToFit()
                .clipped()
                .frame(width: picSize, height: picSize)
                .background(Color.black)
            
            LinearGradient(gradient: Gradient(colors: [Color.clear, Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)
            
            VStack{
                Spacer()
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
                }.padding()
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .bold))
            }
        }
        .frame(width: postSize, height: postSize)
        .onAppear(){
            Firestore.firestore().collection("").document(self.postId).addSnapshotListener { querySnapshot, error in
                guard let document = querySnapshot else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                
                print("new recipe found with listener - Me_PostView")
                if let data = document.data() { // Set recipePost
                    print("\(document.documentID) => \(data)")
                    
                    self.post = RecipePost.init(
                        postingUser: data["postingUser"] as? String ?? "",
                        description: data["description"] as? String ?? "",
                        numberOfLike: data["numberOfLike"] as? Int ?? 0,
                        images: data["description"] as? [String] ?? [],
                        title: data["title"] as? String ?? "",
                        steps: [],
                        ingredients: [],
                        prepTime: 1, prepTimeUnit: .min, cookTime: 1, cookTimeUnit: .min
                    )
                    
                    if ((data["steps"] as? [String: Any]) != nil) {
                        addNewItem(newItem_type: newStep_Ingr.step, data: data["steps"] as! [String : Any])
                    }
                    if ((data["ingredients"] as? [String: Any]) != nil) {
                        addNewItem(newItem_type: newStep_Ingr.step, data: data["ingredients"] as! [String : Any])
                    }
                }
            }
        }
    }
    
    func addNewItem(newItem_type: newStep_Ingr, data: [String: Any]){
        if newItem_type == .step {
            self.post.steps.append(Step(description: data["description"] as? String ?? ""))
        }
        else if newItem_type == .ingr {
            self.post.ingredients.append(
                Ingredient(
                    name: data["name"] as? String ?? "",
                    amount: data["amount"] as? Double ?? 0,
                    amountUnit: IngredientUnit(rawValue: data["amountUnit"] as? String ?? "") ?? IngredientUnit.cup)
            )
        }
    }
}
