//
//  NewPostView.swift
//  recipe
//
//  Created by mac on 2/23/21.
//

import SwiftUI
import SPAlert

struct NewPostView: View {
    @EnvironmentObject var env: GlobalEnvironment
    
    @State private var image: UIImage?
    
    @State private var showSheet = false
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    
    @State var halfModalShown = false
    @State var halfModal_title: String = "title"
    @State var halfModal_placeholder: String = "placeholder"
    @State var halfModal_text: String = ""
    @State var halfModal_number: String = ""
    @State var halfModal_height: CGFloat = 300
    
    @State var newItem_type: newStep_Ingr = .step
    @State var ingredientUnit_index = 0
    
    enum newStep_Ingr{
        case step, ingr
    }
    
    // Sample data
    @State var steps: [Step] = []
    @State var ingredients: [Ingredient] = []
    
    var body: some View {
        ZStack{
            VStack{
                Spacer().frame(height: 65)
                
                ZStack{
                    // Chosen image
                    HStack{
                        if image != nil {
                            Image(uiImage: image!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                                .background(Color.black)
                        }
                        else {
                            
                            Button(action: {
                                self.showSheet.toggle()
                            }) {
                                //Icons made by <a href="https://www.flaticon.com/authors/good-ware" title="Good Ware">Good Ware</a> from <a href="https://www.flaticon.com/" title="Flaticon"> www.flaticon.com</a>
                                Image("pasta_icon")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(100)
                                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                                    .background(Color.init(red: 1, green: 1, blue: 1))
                            }
                        }
                    }
                    
                    // Add button
                    VStack{
                        HStack{
                            Spacer()
                            
                            Button(action: {
                                self.showSheet.toggle()
                            }) {
                                ZStack{
                                    Image(systemName: "plus.circle")
                                        .foregroundColor(.black)
                                    
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.white)
                                }
                                .font(.system(size: 30))
                                .shadow(radius: 4)
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
                                        self.sourceType = .savedPhotosAlbum
                                    },
                                    .cancel()
                                ])
                            }
                        }
                        Spacer()
                    }
                }
                
                VStack{
                    HStack(spacing: 0) {
                        // Ingredients view
                        VStack(spacing: 0) {
                            Text("INGREDIENTS")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(vdarkBlue)
                                .foregroundColor(.white)
                            
                            ScrollView{
                                HStack(spacing: 0) {
                                    VStack(alignment: .leading) {
                                        if ingredients.count <= 0 {
                                            Text("No ingredient")
                                        }
                                        
                                        ForEach(ingredients, id: \.id) {ingr in
                                            Text("\(ingr.amount.stringWithoutZeroFraction) \(ingr.amountUnit.rawValue) \(ingr.name)")
                                        }
                                    }.padding()
                                    
                                    Spacer()
                                }
                            }.frame(width: UIScreen.main.bounds.size.width / 2)
                            .clipped()
                            
                            Button(action: {
                                self.halfModal_update(
                                    title: "ADD NEW INGREDIENT",
                                    placeholder: "E.g.: Egg",
                                    itemType: newStep_Ingr.step,
                                    height: self.halfModal_height)
                                
                                self.newItem_type = .ingr
                                self.halfModalShown.toggle()
                            }){
                                Text("Add an ingredient")
                                    .padding()
                                    .foregroundColor(.white)
                                    .font(.system(size: 16, weight: .bold))
                                    .frame(height: 30)
                                    .background(medblue)
                                    .cornerRadius(15)
                            }
                        }.background(Color.clear)
                        
                        Rectangle()
                            .frame(width: 1, height: 300, alignment: .bottom)
                            .background(Color.gray)
                        
                        // Steps view
                        VStack(spacing: 0) {
                            Text("STEPS")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(vdarkBlue)
                                .foregroundColor(.white)
                            
                            ScrollView{
                                HStack(spacing: 0) {
                                    VStack(alignment: .leading) {
                                        if steps.count <= 0 {
                                            Text("No instruction")
                                        }
                                        
                                        ForEach(steps, id: \.id) {step in
                                            Text(step.description)
                                        }
                                    }.padding()
                                    
                                    Spacer()
                                }
                            }.frame(width: UIScreen.main.bounds.size.width / 2)
                            .clipped()
                            
                            Button(action: {
                                self.halfModal_update(
                                    title: "ADD NEW STEP",
                                    placeholder: "E.g.: Add sugar",
                                    itemType: newStep_Ingr.step,
                                    height: self.halfModal_height)
                                
                                self.newItem_type = .step
                                self.halfModalShown.toggle()
                            }){
                                Text("Add a step")
                                    .padding()
                                    .foregroundColor(.white)
                                    .font(.system(size: 16,weight: .bold))
                                    .frame(height: 30)
                                    .background(medblue)
                                    .cornerRadius(15)
                            }
                        }.background(Color.clear)
                    }
                    
                    Button(action: {
                        if let postImage = self.image {
                            let post = RecipePost(
                                postingUser: self.env.currentUser.establishedID,
                                description: "",
                                numberOfLike: 0,
                                image: Image(uiImage: postImage),
                                steps: self.steps,
                                ingredients: self.ingredients,
                                prepTime: 1, prepTimeUnit: .min, cookTime: 1, cookTimeUnit: .min)
                            
                            print(post.dict)
                            
                            firebaseSubmit(docRef_string: "recipe/\(post.id)", data: post.dict, completion: { _ in })
                            
                            uploadImage("recipe/\(post.id)_1", image: postImage, completion: { _ in })
                        }
                        else {
                            let alertView = SPAlertView(title: "Add a photo", message: "You cannot submit a post without a photo", preset: SPAlertIconPreset.error)
                            alertView.present(duration: 3)
                        }
                    }) {
                        Text("Post")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(20)
                            .frame(height: 48)
                            .frame(maxWidth: .infinity)
                            .background(darkBlue)
                            .shadow(radius: 3)
                    }
                    
                    Spacer().frame(height: 65)
                }
                .background(Color.init(red: 0.95, green: 0.95, blue: 0.95))
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showImagePicker) {
                VStack(spacing: 0) {
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(0..<10) {_ in
                                Rectangle()
                                    .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .background(Color.blue)
                                    .shadow(radius: 3)
                            }
                        }.padding()
                    }.frame(height: 220)
                    .background((Color.white))
                    
                    HStack{
                        Button(action: {self.showImagePicker.toggle()}){
                            Text("DONE")
                                .padding()
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                                .frame(height: 30)
                                .background(medblue)
                                .cornerRadius(15)
                        }
                    }.frame(height: 57)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .zIndex(1)
                    
                    imagePicker(image: self.$image, sourceType: self.sourceType)
                        .offset(y:-57)
                    
                }
            }
            
            HalfModalView(isShown: $halfModalShown, modalHeight: halfModal_height) {
                VStack{
                    Spacer().frame(height: 15)
                    
                    Text("\(self.halfModal_title)").font(.headline)
                    
                    VStack{
                        HStack{
                            // ingredient amount
                            if self.newItem_type == .ingr{
                                CustomTextField(
                                    placeholder: Text("0").foregroundColor(Color.gray),
                                    text: self.$halfModal_number)
                                    .background(
                                        Rectangle()
                                            .cornerRadius(10)
                                            .foregroundColor(Color.init(red: 0.95, green: 0.95, blue: 0.95))
                                    ).keyboardType(.numberPad)
                                    .frame(width: 50)
                                
                                Picker(selection: self.$ingredientUnit_index, label: Text("Unit")){
                                    ForEach (0..<IngredientUnit.allCases.count) {
                                        Text(IngredientUnit.allCases[$0].rawValue)
                                            .tag($0)
                                    }
                                }
                                .labelsHidden()
                                .frame(width: 110, height: 70)
                                .clipped()
                                .padding()
                            }
                            
                            // ingredient and step description
                            CustomTextField(
                                placeholder: Text("\(self.halfModal_placeholder)").foregroundColor(Color.gray),
                                text: self.$halfModal_text)
                                .background(
                                    Rectangle()
                                        .cornerRadius(10)
                                        .foregroundColor(Color.init(red: 0.95, green: 0.95, blue: 0.95))
                                )
                        }
                        
                        // ingredient unit
                        if self.newItem_type == .ingr {
                            
                        }
                    }
                    
                    Button(action: {
                        self.addNewItem()
                    }){
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    func halfModal_update(title: String, placeholder: String, itemType: newStep_Ingr, height: CGFloat){
        self.halfModal_text = ""
        self.halfModal_number = ""
        
        halfModal_title = title
        halfModal_placeholder = placeholder
        newItem_type = itemType
        halfModal_height = height
    }
    
    func halfModal_hide(){
        UIApplication.shared.endEditting()
        halfModalShown = false
    }
    
    func addNewItem(){
        if halfModal_text == "" {
            let alertView = SPAlertView(title: newItem_type == .step ? "Please add a step instruction": "Please add an ingredient", message: nil, preset: SPAlertIconPreset.error)
            alertView.present(duration: 3)
        }
        else {
            if newItem_type == .step {
                steps.append(
                    Step(
                        description: halfModal_text,
                        order: steps.count))
                
                self.halfModal_hide()
            }
            else if newItem_type == .ingr {
                if let number = convertStringToDouble(halfModal_number) {
                    let unit = IngredientUnit.allCases[ingredientUnit_index]
                    
                    ingredients.append(
                        Ingredient(
                            name: halfModal_text,
                            amount: number,
                            amountUnit: unit,
                            order: ingredients.count))
                    
                    self.halfModal_hide()
                }
                else {
                    let alertView = SPAlertView(title: "Check the amount", message: "Please enter a number (i.e.: \"1\" or \"1.3\"", preset: SPAlertIconPreset.error)
                    alertView.present(duration: 3)
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

