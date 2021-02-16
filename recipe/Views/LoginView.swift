//
//  LoginView.swift
//  recipe
//
//  Created by mac on 2/15/21.
//

import SwiftUI

struct LoginView: View {
    @State private var signup_visible = false
    
    var body: some View {
        VStack(spacing: 0) {
            Image("fadeCarrousel_2")
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(height: 300)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.clear)
                .edgesIgnoringSafeArea(.top)
            
            TextField("Username", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color.clear)
            TextField("Password", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color.clear)
            
            Spacer()
                .frame(height: 20)
            
            Button(action: {}) {
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
            .sheet(isPresented: $signup_visible, content: {Text("this is sign up page")})
            .cornerRadius(10)
            
            Spacer()
        }
        .background(Color.clear)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
