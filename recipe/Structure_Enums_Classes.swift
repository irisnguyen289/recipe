//
//  Structure_Enums_Classes.swift
//  recipe
//
//  Created by mac on 2/10/21.
//

import Foundation

import SwiftUI

struct recipePost: Identifiable{
    var id = UUID()
    
    var postingUser: String
    var description: String
    var numberOfLike: Int
    var image: Image
    
}

