//
//  recipeApp.swift
//  recipe
//
//  Created by mac on 2/10/21.
//

import SwiftUI
import Firebase

@main
struct recipeApp: App {
    @ObservedObject var env = GlobalEnvironment()
    
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            LoginView().environmentObject(env)
        }
    }
}
