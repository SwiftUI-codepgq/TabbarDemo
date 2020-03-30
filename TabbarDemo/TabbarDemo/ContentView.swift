//
//  ContentView.swift
//  TabbarDemo
//
//  Created by pgq on 2020/3/30.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var currentIndex: Int = 0
    var body: some View {
        TabView(selection: $currentIndex) {
            HomeView()
                .tabItem {
                    homeImage
                    Text("主页")
            }
            .tag(0)
            
            MineView()
                .tabItem {
                    mineImage
                    Text("我的")
            }
            .tag(1)
        }
        .foregroundColor(.gray)
        .accentColor(.orange)
    }
    
    private var mineImage: some View {
        let name = currentIndex == 1 ? "person.fill" : "person"
        return Image(systemName: name)
    }
    
    private var homeImage: some View {
        let name = currentIndex == 0 ? "house.fill" : "house"
        return Image(systemName: name)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
