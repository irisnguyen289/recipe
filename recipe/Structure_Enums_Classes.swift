//
//  Structure_Enums_Classes.swift
//  recipe
//
//  Created by mac on 2/10/21.
//

import Foundation

import SwiftUI

var lightBlue = Color.init(red: 91/255, green: 152/255, blue: 198/255)
var darkBlue = Color.init(red: 47/255, green: 75/255, blue: 135/255)
var vdarkBlue = Color.init(red: 2/255, green: 51/255, blue: 92/255)

enum IngredientUnit: String {
    case cup = "cup"
    case tablespoon = "tablespoon"
    case teaspoon = "teaspoon"
    case pinch = "cupinchp"
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

enum timeUnit: String {
    case sec = "seconds"
    case min = "mins"
    case hr = "hours"
    case day = "days"
}

struct User: Identifiable{
    var id = UUID()
    
    var username: String
    var password: String
    var name: String
    var email: String
}

struct RecipePost: Identifiable{
    var id = UUID()
    
    var postingUser: String
    var description: String
    var numberOfLike: Int
    var image: Image
    
    var steps: [Step]
    var ingredients: [Ingredient]
    
    var prepTime: Int = 10
    var prepTimeUnit: timeUnit = .min
    
    var cookTime: Int = 10
    var cookTimeUnit: timeUnit = .min
}

struct Ingredient: Identifiable{
    var id = UUID()
    
    var name: String
    var amount: Double
    var amountUnit: IngredientUnit
    var order: Int
}

struct Step: Identifiable{
    var id = UUID()
    
    var description: String
    var order: Int
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
    @Published var currentUser: User = User.init(username: "", password: "", name: "", email: "")
    
    // Global - Visual Items
    // var tabBar_Height: CGFloat = 48
    // var mp_height: CGFloat = 50
    //
    // var is_EPPresent = false
    // var is_morePresent = false
    //
    // var layoutUnit: CGFloat = 150
}
