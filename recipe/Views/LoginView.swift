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
    @ObservedObject var env = GlobalEnvironment()
    
    @State private var signup_visible = false
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [darkBlue, vdarkBlue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    Image("recipeat_slogan")
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .frame(width: UIScreen.main.bounds.size.width / 2)
                        .background(Color.clear)
                    
                    VStack{
                        CustomTextField(
                            placeholder: Text("Username").foregroundColor(.white),
                            text: $username)
                            .foregroundColor(.white)
                            .overlay(
                                Capsule()
                                    .stroke(lineWidth: 2))
                            .padding()
                        
                        CustomSecureField(
                            placeholder: Text("Password").foregroundColor(.white),
                            text: $password)
                            .overlay(
                                Capsule()
                                    .stroke(lineWidth: 2))
                            .padding()
                    }
                    .foregroundColor(.white)
                    
                    NavigationLink(destination: TabbedRootView(), isActive: $isLoggedIn) {
                        Button(action: {
                            Firestore.firestore().collection("users").whereField("username", isEqualTo: self.username).getDocuments(){ (querySnapshot, err) in
                                if let err = err {
                                    print("Error getting documents: \(err)")
                                } else{
                                    if querySnapshot!.documents.count <= 0 {
                                        let alertView = SPAlertView(title: "Invalid username", message: nil, preset: SPAlertIconPreset.error)
                                        alertView.present(duration: 3)
                                        
                                        print("No user found")
                                    }
                                    else if querySnapshot!.documents.count > 1 {
                                        let alertView = SPAlertView(title: "Something went wrong", message: nil, preset: SPAlertIconPreset.error)
                                        alertView.present(duration: 3)
                                        
                                        print("More than one user found")
                                    }
                                    else {
                                        for document in querySnapshot!.documents{
                                            print("\(document.documentID) => \(document.data())")
                                            
                                            // Verification
                                            if document.data()["password"] as? String ?? "" == self.password {
                                                // Set user
                                                env.currentUser = User.init(
                                                    username: document.data()["username"] as? String ?? "",
                                                    password: document.data()["password"] as? String ?? "",
                                                    name: document.data()["name"] as? String ?? "",
                                                    email: document.data()["email"] as? String ?? "",
                                                    document.documentID
                                                )
                                                
                                                // Save user to maintain log in session
                                                env.save_UserDefaults()
                                                
                                                // Change to HomeView
                                                self.isLoggedIn = true
                                            }
                                            else{
                                                let alertView = SPAlertView(title: "Incorrect password", message: nil, preset: SPAlertIconPreset.error)
                                                alertView.present(duration: 3)
                                            }
                                            
                                            break
                                        }
                                    }
                                }
                            }
                        }) {
                            HStack{
                                Text("Log In")
                                Image(systemName: "arrow.right")
                            }
                            .frame(height: 50)
                            .frame(width: UIScreen.main.bounds.size.width / 3)
                            .foregroundColor(.white)
                        }
                        .background(lightBlue)
                        .cornerRadius(25)
                        .padding()
                    }.onAppear(){
                        if let lastLogin_User = UserDefaults.standard.object(forKey: "lastLogin_User") as? Data {
                            do{
                                if let lastSession = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(lastLogin_User) as? [String: Any?] {
                                    if let savedUser = lastSession["last_login_user"] as? User {
                                        print("logged in successfully with saved user")
                                        print(savedUser)
                                        
                                        self.env.currentUser = savedUser
                                    }
                                    else {
                                        print("couldn't unwrap user")
                                        print(lastSession)
                                        print(lastSession["last_login_user"])
                                    }
                                    
                                    self.isLoggedIn = true
                                    print("auto login to last session successfully")
                                }
                            }
                            catch{
                                print("couldn't read data lastLogin_User")
                            }
                        }
                        else{
                            print("couldn't read data lastLogin_User")
                        }
                    }
                    
                    
                    Spacer()
                    
                    Button(action: {
                        self.signup_visible.toggle()
                    }) {
                        Text("Sign Up").padding()
                    }
                    .foregroundColor(Color.init(red: 0.85, green: 0.85, blue: 0.85))
                    .sheet(isPresented: $signup_visible, content: {SignUpView()})
                    .overlay(
                        Capsule()
                            .stroke(lineWidth: 2)
                            .foregroundColor(lightBlue))
                }
                .background(Color.clear)
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
