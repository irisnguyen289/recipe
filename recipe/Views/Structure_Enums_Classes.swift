//
//  Structure_Enums_Classes.swift
//  recipe
//
//  Created by mac on 2/10/21.
//

import Foundation

import SwiftUI

var vlightBlue = Color.init(red: 130/255, green: 209/255, blue: 255/255)
var lightBlue = Color.init(red: 117/255, green: 188/255, blue: 230/255)
var medblue = Color.init(red: 98/255, green: 157/255, blue: 191/255)
var darkBlue = Color.init(red: 65/255, green: 105/255, blue: 128/255)
var vdarkBlue = Color.init(red: 33/255, green: 52/255, blue: 64/255)

enum IngredientUnit: String, CaseIterable {
    case cup = "cup"
    case tbsp = "tablespoon"
    case tsp = "teaspoon"
    case pinch = "pinch"
    case dash = "dash"
    case mL = "mL"
    case L = "L"
    case oz = "oz"
    case kg = "kg"
    case mg = "mg"
    case g = "g"
    case lb = "lb"
    case whole = "whole"
}

enum timeUnit: String, CaseIterable {
    case sec = "seconds"
    case min = "mins"
    case hr = "hours"
    case day = "days"
}

class User: NSObject, Identifiable, NSCoding {
    var id = UUID()
    var establishedID: String
    
    var username: String
    var password: String
    var name: String
    var email: String
    
    var publishedRecipes: [String] = []
    
    init(username: String, password: String, name: String, email: String, publishedRecipes: [String], _ idString: String?){
        self.username = username
        self.password = password
        self.name = name
        self.email = email
        self.publishedRecipes = publishedRecipes
        
        if let idString = idString {
            self.establishedID = idString
        }
        else{
            self.establishedID = id.uuidString
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? UUID ?? UUID()
        establishedID = aDecoder.decodeObject(forKey: "establishedID") as? String ?? ""
        username = aDecoder.decodeObject(forKey: "username") as? String ?? ""
        password = aDecoder.decodeObject(forKey: "password") as? String ?? ""
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
        publishedRecipes = aDecoder.decodeObject(forKey: "publishedRecipes") as? [String] ?? []
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(establishedID, forKey: "establishedID")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(publishedRecipes, forKey: "publishedRecipes")
    }
}

struct Identifiable_UIImage: Identifiable {
    var id = UUID()
    var image: UIImage
}

struct trunc_RecipePost: Identifiable {
    var id = UUID()
    
    var title: String
    var description: String
    
    var dict: [String: Any] {
        return [
            "id": id.uuidString,
            "title": title,
            "description": description
        ]
    }
}

struct RecipePost: Identifiable{
    var id = UUID()
    
    var postingUser: String
    var description: String
    var numberOfLike: Int
    var images: [String]
    
    var title: String
    var steps: [Step]
    var ingredients: [Ingredient]
    
    var prepTime: Int = 10
    var prepTimeUnit: timeUnit = .min
    
    var cookTime: Int = 10
    var cookTimeUnit: timeUnit = .min
    
    var dict: [String: Any] {
        return [
            "id": id.uuidString,
            "postingUser": postingUser,
            "description": description,
            "numberOfLike": numberOfLike,
            "images": images,
            "title": title,
            "steps": steps.formatForFirebase(),
            "ingredients": ingredients.formatForFirebase()
        ]
    }
}

struct Ingredient: Identifiable{
    var id = UUID()
    
    var name: String
    var amount: Double
    var amountUnit: IngredientUnit
    
    var dict: [String: Any] {
        return [
            "id": id.uuidString,
            "name": name,
            "amount": amount,
            "amountUnit": amountUnit.rawValue
        ]
    }
}

struct Step: Identifiable{
    var id = UUID()
    
    var description: String
    
    var dict: [String: Any] {
        return [
            "id": id.uuidString,
            "description": description
        ]
    }
}

struct CustomTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
        }
        .padding()
    }
}

struct CustomSecureField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty { placeholder }
            SecureField("", text: $text, onCommit: commit)
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
        }
        .padding()
    }
}

class GlobalEnvironment: ObservableObject{
    @Published var currentUser: User = User.init(username: "", password: "", name: "", email: "", publishedRecipes: [], nil)
}
