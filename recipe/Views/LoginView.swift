//
//  LoginView.swift
//  recipe
//
//  Created by mac on 2/15/21.
//

import SwiftUI
import Firebase
import SPAlert

struct LoginView: View {
    @State private var signup_visible = false
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [darkBlue, vdarkBlue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        VStack(spacing: 0) {
            Image("fadeCarrousel_2")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(height: 300)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.clear)
                .edgesIgnoringSafeArea(.top)
            
            TextField("Username", text: $username)
                .padding()
                .background(Color.clear)
            TextField("Password", text: $password)
                .padding()
                .background(Color.clear)
            
            Spacer()
                .frame(height: 20)
            
            Button(action: {
                Firestore.firestore().collection("users").whereField("username", isEqualTo: self.username).getDocuments(){ (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else{
                        if querySnapshot!.documents.count <= 0 {
                            let alertView = SPAlertView(title: "No user found", message: "Invalid username", preset: SPAlertIconPreset.error)
                            
                            alertView.present(duration: 3)
                        } else{
                            let alertView = SPAlertView(title: "\(querySnapshot!.documents.count) user(s) found", message: "Valid username", preset: SPAlertIconPreset.done)
                            
                            alertView.present(duration: 3)
                        }
                        
                        for document in querySnapshot!.documents{
                            print("\(document.documentID) => \(document.data())")
                        }
                    }
                }
            }) {
                HStack{
                    Text("Log In")
                    Image(systemName: "arrow.right")
                }
                .padding()
            }
            .background(Color.init(red: 0.85, green: 0.85, blue: 0.85))
            .cornerRadius(10)
            
            Spacer()
            Button(action: {
                self.signup_visible.toggle()
            }) {
                Text("Sign Up").padding()
            }
            .background(Color.clear)
            .foregroundColor(Color.init(red: 0.85, green: 0.85, blue: 0.85))
            .sheet(isPresented: $signup_visible, content: {SignUpView()})
            .cornerRadius(10)
            
            Spacer()
        }
        .background(Color.clear)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
