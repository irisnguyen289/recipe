//
//  ModifyPost.swift
//  recipe
//
//  Created by mac on 4/17/21.
//

import SwiftUI

struct ModifyPost: View {
    @Binding var recipe: RecipePost
    @Binding var images: [Identifiable_UIImage]
    
    @State var steps: [String] = ["a", "b","c"]
    @State var editingStep = false
    @State var editingIngredients = false
    
    @State var listType: newStep_Ingr = .step
    
    var body: some View {
        VStack{
            // Chosen image
            HStack{
                if images.count > 0 {
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            ForEach(self.images, id: \.id) {i in
                                Image(uiImage: i.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.size.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .shadow(radius: 3)
                            }
                        }
                    }.frame(height: UIScreen.main.bounds.size.width)
                    .background((Color.black))
                }
                else {
                    Text("No Image")
                        .frame(height: 300)
                }
            }
            
            TextField("Recipe name:", text: $recipe.title)
            TextField("Description:", text: $recipe.description)
            
            HStack{ // allow user sorting ingredients and steps
                List(){
                    ForEach(recipe.ingredients, id: \.id) { ingr in
                        Text("\(ingr.name)")
                            .padding()
                            .background(Color.red)
                            .cornerRadius(5)
                            .lineLimit(nil)
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)
                    .onLongPressGesture{
                        withAnimation{
                            self.listType = .ingr
                            self.editingIngredients = true
                        }
                    }
                }
                .environment(\.editMode, editingIngredients ? .constant(.active) : .constant(.inactive))
                
                List(){
                    ForEach(recipe.steps, id: \.id) { step in
                        Text("\(step.description)")
                            .padding()
                            .background(Color.green)
                            .cornerRadius(5)
                            .lineLimit(nil)
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)
                    .onLongPressGesture{
                        withAnimation{
                            self.listType = .step
                            self.editingStep = true
                        }
                    }
                }
                .environment(\.editMode, editingStep ? .constant(.active) : .constant(.inactive))
            }
            Spacer()
            
        }
    }
    
    func delete(at offsets: IndexSet){
        print(offsets)
        if listType == .step {
            self.recipe.steps.remove(atOffsets: offsets)
        } else {
            self.recipe.ingredients.remove(atOffsets: offsets)
        }
    }
    
    func move(fromOffsets source: IndexSet, toOffset dest: Int){
        if listType == .step {
            self.recipe.steps.move(fromOffsets: source, toOffset: dest)
        } else {
            self.recipe.ingredients.move(fromOffsets: source, toOffset: dest)
        }
        withAnimation{
            self.editingIngredients = false
            self.editingStep = false
        }
    }
}
//
//struct ModifyPost_Previews: PreviewProvider {
//    static var previews: some View {
//        ModifyPost(title: .constant("temp"))
//    }
//}
