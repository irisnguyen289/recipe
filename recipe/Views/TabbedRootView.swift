//
//  ContentView.swift
//  recipe
//
//  Created by mac on 2/10/21.
//

import SwiftUI

struct TabbedRootView: View {
    @State private var selection = 0
    @State private var navBarHidden = true
        
    var body: some View {
        
        ZStack{
            NavigationView{
                Text("d")
            }.navigationBarTitle("")
            .navigationBarHidden(self.navBarHidden)
            .onAppear(perform: {
                self.navBarHidden = true
            })
            
            TabView(selection: $selection){
                HomeView()
                    .tabItem{
                            Image(systemName: "house")
                            Text("Home")
                    }
                    .tag(0)
                SearchView()
                    .tabItem{
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                    }
                    .tag(1)
                NewPostView()
                    .tabItem{
                            Image(systemName: "plus.square")
                            Text("Add Recipe")
                    }
                    .tag(2)
                MeView()
                    .tabItem{
                            Image(systemName: "person.circle")
                            Text("Me")
                    }
                    .tag(3)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedRootView()
    }
}
