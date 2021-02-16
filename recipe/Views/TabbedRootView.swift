//
//  ContentView.swift
//  recipe
//
//  Created by mac on 2/10/21.
//

import SwiftUI

struct TabbedRootView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection){
            HomeView()
                .tabItem{
                    VStack{
                        Image(systemName: "house")
                        Text("Home")
                    }
                }
                .tag(0)
            SearchView()
                .tabItem{
                    VStack{
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                }
                .tag(1)
            MeView()
                .tabItem{
                    VStack{
                        Image(systemName: "person.circle")
                        Text("Me")
                    }
                }
                .tag(2)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedRootView()
    }
}
