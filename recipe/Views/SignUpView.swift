//
//  SignUpView.swift
//  recipe
//
//  Created by mac on 2/15/21.
//

import SwiftUI
import Firebase
import SPAlert

struct SignUpView: View {
    @State private var name: String = ""
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    
    @State private var docRef: DocumentReference!
    
    var body: some View {
        ZStack{
            Image("fadeCarrousel_2_blur")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).opacity(0.2)
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.white]), startPoint: .top, endPoint: .bottom).opacity(0.2)
                Color.white.opacity(0.1)
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            VStack{
                Image("recipeat_logo")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 5, y: 5)
                
                Spacer().frame(height: 50)
                
                VStack(spacing: 0){
                    CustomTextField(
                        placeholder: Text("Name"),
                        text: self.$name)
                        .frame(height: 40)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.white)
                        .opacity(0.2)
                    
                    CustomTextField(
                        placeholder: Text("Username"),
                        text: self.$userName)
                        .frame(height: 40)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.white)
                        .opacity(0.2)
                    
                    CustomSecureField(
                        placeholder: Text("Password"),
                        text: self.$password)
                        .frame(height: 40)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.white)
                        .opacity(0.2)
                    
                    CustomTextField(
                        placeholder: Text("Email"),
                        text: self.$email)
                        .frame(height: 40)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.white)
                        .opacity(0.2)
                }
                
                Spacer().frame(height: 30)
                
                Button(action: {
                    let dataToSave: [String: Any] =
                        [
                            "username": self.userName,
                            "password": self.password,
                            "name": self.name,
                            "email": self.email
                        ]
                    
                    print("setting docRef")
                    self.docRef = Firestore.firestore().document("users/\(UUID().uuidString)")
                    
                    print("setting data")
                    self.docRef.setData(dataToSave) { (error) in
                        if let error = error{
                            print("error = \(error)")
                        } else {
                            let alertView = SPAlertView(title: "Account created successful", message: "Valid username", preset: SPAlertIconPreset.done)
                            
                            alertView.present(duration: 3)
                            print("no error")
                        }
                    }
                    print("done")
                }) {
                    HStack{
                        Text("Sign up")
                        Image(systemName: "checkmark")
                    }.foregroundColor(vdarkBlue)
                    .frame(height: 50)
                    .frame(width: UIScreen.main.bounds.size.width / 3)
                }
                .background(lightBlue)
                .cornerRadius(25)
                
                Spacer().frame(height: 200)
            }
            .padding(30)
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
