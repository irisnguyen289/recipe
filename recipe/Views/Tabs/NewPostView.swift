//
//  NewPostView.swift
//  recipe
//
//  Created by mac on 2/23/21.
//

import SwiftUI

struct NewPostView: View {
    @State private var image: UIImage?
    
    @State private var showSheet = false
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State var halfModalShown = false
    @State var halfModal_title: String = "title"
    @State var halfModal_placeholder: String = "placeholder"
    @State var halfModal_val: String = ""
    
    // Sample data
    var steps: [Step] = [
        Step(description: "add egg", order: 1),
        Step(description: "add sugar", order: 2),
        Step(description: "add milk", order: 3),
        Step(description: "add flour", order: 4)
    ]
    var ingredients: [Ingredient] = [
        Ingredient(name: "egg", amount: 3, amountUnit: .whole, order: 1),
        Ingredient(name: "sugar", amount: 3, amountUnit: .tablespoon, order: 2),
        Ingredient(name: "milk", amount: 4, amountUnit: .oz, order: 3),
        Ingredient(name: "flour", amount: 2, amountUnit: .cup, order: 4),
        Ingredient(name: "egg", amount: 3, amountUnit: .whole, order: 1),
        Ingredient(name: "sugar", amount: 3, amountUnit: .tablespoon, order: 2),
        Ingredient(name: "milk", amount: 4, amountUnit: .oz, order: 3),
        Ingredient(name: "flour", amount: 2, amountUnit: .cup, order: 4),
        Ingredient(name: "egg", amount: 3, amountUnit: .whole, order: 1),
        Ingredient(name: "sugar", amount: 3, amountUnit: .tablespoon, order: 2),
        Ingredient(name: "milk", amount: 4, amountUnit: .oz, order: 3),
        Ingredient(name: "flour", amount: 2, amountUnit: .cup, order: 4),
        Ingredient(name: "egg", amount: 3, amountUnit: .whole, order: 1),
        Ingredient(name: "sugar", amount: 3, amountUnit: .tablespoon, order: 2),
        Ingredient(name: "milk", amount: 4, amountUnit: .oz, order: 3),
        Ingredient(name: "flour", amount: 2, amountUnit: .cup, order: 4)
    ]
    
    var body: some View {
        ZStack{
            VStack{
                ZStack{
                    // Chosen image
                    HStack{
                        if image != nil {
                            Image(uiImage: image!).resizable()
                                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                                .scaledToFit()
                        }
                        else {
                            Image(systemName: "timelapse")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                                .scaledToFit()
                                .background(Color.red)
                        }
                    }
                    
                    // Add button
                    VStack{
                        HStack{
                            Spacer()
                            
                            Button(action: {
                                self.showSheet.toggle()
                            }) {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 30))
                                    .foregroundColor(.black)
                                    .shadow(radius: 3)
                                    .cornerRadius(15)
                                    .opacity(0.7)
                                    .padding()
                            }.actionSheet(isPresented: $showSheet){
                                ActionSheet(title: Text("Add a picture to your post"), message: nil, buttons: [
                                    .default(Text("Camera")) {
                                        self.showImagePicker = true
                                        self.sourceType = .camera
                                    },
                                    .default(Text("Photo Library")) {
                                        self.showImagePicker = true
                                        self.sourceType = .photoLibrary
                                    },
                                    .cancel()
                                ])
                            }
                        }
                        Spacer()
                    }
                }
                HStack{
                    // Ingredients view
                    ZStack{
                        VStack(spacing: 0) {
                            Text("Ingredients")
                                .padding()
                            
                            ScrollView{
                                HStack(spacing: 0) {
                                    VStack(alignment: .leading) {
                                        ForEach(ingredients, id: \.id) {ingr in
                                            Text("\(ingr.amount) \(ingr.name)")
                                        }
                                    }.padding()
                                    
                                    Spacer()
                                }
                            }.frame(width: UIScreen.main.bounds.size.width / 2)
                            .clipped()
                        }.background(Color.yellow)
                        
                        VStack{
                            HStack{
                                Spacer()
                                
                                Button(action: {
                                    self.halfModal_title = "Add new ingredient"
                                    self.halfModal_placeholder = "E.g.: Egg"
                                    self.halfModalShown.toggle()
                                }){
                                    Image(systemName: "plus.circle")
                                        .padding()
                                }
                            }
                            Spacer()
                        }
                    }
                    
                    // Steps view
                    ZStack{
                        VStack(spacing: 0) {
                            Text("Steps").padding()
                            
                            ScrollView{
                                HStack(spacing: 0) {
                                    VStack(alignment: .leading) {
                                        ForEach(steps, id: \.id) {step in
                                            Text(step.description)
                                        }
                                    }.padding()
                                    
                                    Spacer()
                                }
                            }.frame(width: UIScreen.main.bounds.size.width / 2)
                            .clipped()
                        }.background(Color.green)
                        
                        VStack{
                            HStack{
                                Spacer()
                                
                                Button(action: {
                                    self.halfModal_title = "Add new step"
                                    self.halfModal_placeholder = "E.g.: Add sugar"
                                    
                                    self.halfModalShown.toggle()
                                }){
                                    Image(systemName: "plus.circle")
                                        .padding()
                                }
                            }
                            Spacer()
                        }
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showImagePicker) {
                VStack{
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(0..<10) {_ in
                                Rectangle()
                                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.blue)
                            }
                        }.padding()
                    }.frame(height: 220)
                    .background((Color.pink))
                    
                    imagePicker(image: self.$image, sourceType: self.sourceType)
                    
                }
            }
            
            HalfModalView(isShown: $halfModalShown) {
                VStack{
                    Text("\(self.halfModal_title)")
                    CustomTextField(
                        placeholder: Text("\(self.halfModal_placeholder)").foregroundColor(Color.gray),
                        text: self.$halfModal_val)
                }
            }
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}

