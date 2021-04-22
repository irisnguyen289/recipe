//
//  NewPostView.swift
//  recipe
//
//  Created by mac on 2/23/21.
//

import SwiftUI
import SPAlert

enum newStep_Ingr{
    case step, ingr
}

struct NewPostView: View {
    @EnvironmentObject var env: GlobalEnvironment
    
    @State private var images: [Identifiable_UIImage] = []
    
    @State private var showPreviewSheet = false
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
        
    @State var posted = false
    @State var updatedUserPost = false
    @State var uploadedImages = false
    
    @State var recipe = RecipePost.init(
        postingUser: "",
        description: "",
        numberOfLike: 0,
        images: [],
        title: "",
        steps: [],
        ingredients: [],
        prepTime: 1, prepTimeUnit: .min, cookTime: 1, cookTimeUnit: .min)
    
    var body: some View {
        ZStack{
            VStack{
                Spacer().frame(height: 65)
                
                ZStack{
                    // Chosen image
                    HStack{
                        if self.images.count > 0 {
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
                    
                    // Add image button
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
                            }.actionSheet(isPresented: self.$showSheet){
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
                .sheet(isPresented: self.$showImagePicker) {
                    VStack(spacing: 0) {
                        if self.images.count > 0 {
                            ScrollView(.horizontal) {
                                HStack{
                                    ForEach(self.images, id: \.id) {i in
                                        Image(uiImage: i.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                            .background(Color.black)
                                            .shadow(radius: 3)
                                    }
                                }.padding()
                            }.frame(height: 220)
                            .background((Color.white))
                        }
                        else {
                            HStack{
                                Spacer()
                                Text("Choose image(s)")
                                Spacer()
                            }.frame(height: 220)
                            .background((Color.white))
                        }
                        
                        HStack{
                            Button(action: {self.showImagePicker.toggle()}){
                                Text("DONE - \(self.images.count) images")
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
                        
                        imagePicker(images: self.$images, sourceType: self.sourceType)
                            .offset(y:-57)
                        
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
                            
                            // Ingredients list
                            ScrollView{
                                HStack(spacing: 0) {
                                    VStack(alignment: .leading) {
                                        if self.recipe.ingredients.count <= 0 {
                                            Text("No ingredient")
                                        }
                                        
                                        ForEach(self.recipe.ingredients, id: \.id) {ingr in
                                            Text("\(ingr.amount.stringWithoutZeroFraction) \(ingr.amountUnit.rawValue) \(ingr.name)")
                                                .padding(8)
                                                .background(Color.init(red: 0.85, green: 0.85, blue: 0.85))
                                                .cornerRadius(20)
                                        }
                                    }.padding()
                                    
                                    Spacer()
                                }
                            }.frame(width: UIScreen.main.bounds.size.width / 2)
                            .clipped()
                            
                            // Add ingredient button
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
                        
                        // Steps view
                        VStack(spacing: 0) {
                            Text("STEPS")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(vdarkBlue)
                                .foregroundColor(.white)
                            
                            // Steps list
                            ScrollView{
                                HStack(spacing: 0) {
                                    VStack(alignment: .leading) {
                                        if self.recipe.steps.count <= 0 {
                                            Text("No instruction")
                                        }
                                        
                                        ForEach(self.recipe.steps, id: \.id) {step in
                                            Text(step.description)
                                        }
                                    }.padding()
                                    
                                    Spacer()
                                }
                            }.frame(width: UIScreen.main.bounds.size.width / 2)
                            .clipped()
                            
                            // Add Step button
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
                    
                    // Preview button
                    Button(action: {
                        //self.submitRecipe()
                        self.showPreviewSheet = true
                    }) {
                        Text("Preview")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(20)
                            .frame(height: 48)
                            .frame(maxWidth: .infinity)
                            .background(darkBlue)
                            .shadow(radius: 3)
                    }
                    .sheet(isPresented: self.$showPreviewSheet) {
                        VStack{
                            ModifyPost(recipe: self.$recipe, images: self.$images)
                            
                            // Preview button
                            Button(action: {
                                self.submitRecipe()
                            }) {
                                Text("POST")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(20)
                                    .frame(height: 48)
                                    .frame(maxWidth: .infinity)
                                    .background(darkBlue)
                                    .shadow(radius: 3)
                            }
                        }
                    }
                    
                    Spacer().frame(height: 65)
                }
                .background(Color.init(red: 0.95, green: 0.95, blue: 0.95))
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
            HalfModalView(isShown: self.$halfModalShown, modalHeight: self.halfModal_height) {
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
        self.ingredientUnit_index = 0
        
        self.halfModal_title = title
        self.halfModal_placeholder = placeholder
        self.newItem_type = itemType
        self.halfModal_height = height
    }
    
    func halfModal_hide(){
        UIApplication.shared.endEditting()
        self.halfModalShown = false
    }
    
    func addNewItem(){
        if self.halfModal_text == "" {
            let alertView = SPAlertView(title: newItem_type == .step ? "Please add a step instruction": "Please add an ingredient", message: nil, preset: SPAlertIconPreset.error)
            alertView.present(duration: 3)
        }
        else {
            if self.newItem_type == .step {
                self.recipe.steps.append(Step(description: self.halfModal_text))
                
                self.halfModal_hide()
            }
            else if self.newItem_type == .ingr {
                if let number = convertStringToDouble(self.halfModal_number) {
                    let unit = IngredientUnit.allCases[self.ingredientUnit_index]
                    
                    self.recipe.ingredients.append(
                        Ingredient(
                            name: self.halfModal_text,
                            amount: number,
                            amountUnit: unit))
                    
                    self.halfModal_hide()
                }
                else {
                    let alertView = SPAlertView(title: "Check the amount", message: "Please enter a number (i.e.: \"1\" or \"1.3\"", preset: SPAlertIconPreset.error)
                    alertView.present(duration: 3)
                }
            }
        }
    }
    
    func clearView() {
        self.images.removeAll()
        self.recipe = RecipePost.init(
            postingUser: "",
            description: "",
            numberOfLike: 0,
            images: [],
            title: "",
            steps: [],
            ingredients: [],
            prepTime: 1, prepTimeUnit: .min, cookTime: 1, cookTimeUnit: .min)
    }
    
    func submitRecipe(){
            func showResult(){
                if self.posted && self.updatedUserPost && self.uploadedImages {
                    //self.env.localUpdate_currentUser()
                    
                    let alertView = SPAlertView(title: "Posted", message: "", preset: SPAlertIconPreset.done)
                    alertView.present(duration: 3)
                    
                    self.clearView()
                }
            }
            
            if self.images.count > 0  {
                self.recipe.postingUser = self.env.currentUser.establishedID
                
                print(self.recipe.dict)
                
                self.env.currentUser.publishedRecipes.append(self.recipe.id.uuidString)
                
                // upload images
                var uploadCount = 0
                for i in 0...self.images.count - 1 {
                    let image = self.images[i].image
                    let imageStr = "recipe/\(self.recipe.id)_\(i)"
                    uploadImage(imageStr, image: image, completion: { _ in
                        uploadCount += 1
                        self.recipe.images.append(imageStr)
                        
                        if uploadCount == self.images.count{
                            self.uploadedImages = true
                            showResult()
                        }
                    })
                }
                
                // submit post
                firebaseSubmit(docRef_string: "recipe/\(self.recipe.id)", data: self.recipe.dict, completion: { _ in
                    self.posted = true
                    showResult()
                })
                
                // update user's recipeID list
                firebaseUpdate(docRef_string: "users/\(self.env.currentUser.establishedID)", dataToUpdate: ["publishedRecipes": self.env.currentUser.publishedRecipes], completion: { _ in
                    self.updatedUserPost = true
                    showResult()
                })
            }
            else {
                let alertView = SPAlertView(title: "Add a photo", message: "You cannot submit a post without a photo", preset: SPAlertIconPreset.error)
                alertView.present(duration: 3)
            }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}

