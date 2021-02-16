//
//  SignUpView.swift
//  recipe
//
//  Created by mac on 2/15/21.
//

import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    
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
                
                HStack{
                    VStack{
                        
                        HStack{
                            Text("Name:")
                                .frame(height: 40)
                            Spacer()
                        }
                        HStack{
                            Text("Username:")
                                .frame(height: 40)
                            Spacer()
                        }
                        HStack{
                            Text("Password:")
                                .frame(height: 40)
                            Spacer()
                        }
                        HStack{
                            Text("Email:")
                                .frame(height: 40)
                            Spacer()
                        }
                    }
                    .frame(width: 100)
                    
                    VStack(spacing: 0){
                        TextField("John Smith", text: $name)
                            .frame(height: 40)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.white)
                            .opacity(0.2)
                        
                        TextField("Username", text: $userName)
                            .frame(height: 40)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.white)
                            .opacity(0.2)
                        
                        TextField("Password", text: $password)
                            .frame(height: 40)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.white)
                            .opacity(0.2)
                        
                        TextField("Email", text: $email)
                            .frame(height: 40)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(.white)
                            .opacity(0.2)
                    }
                }
                
                Spacer().frame(height: 30)
                
                Button(action: {
                    print("here")
                }) {
                    HStack{
                        Text("Sign up")
                        Image(systemName: "checkmark")
                    }
                }
                
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
