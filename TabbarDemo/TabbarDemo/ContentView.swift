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
    @State private var isPopover = false
    var body: some View {
        ZStack {
            TabView(selection: $currentIndex) {
                HomeView()
                    .tabItem {
                        homeImage
                        Text("主页")
                }
                .tag(0)
                
                AddView(vm: AddViewVM(phoneNum: "", code: ""))
                    .tabItem {
                        Text("")
                        .disabled(true)
                }.tag(1)
                
                MineView()
                    .tabItem {
                        mineImage
                        Text("我的")
                }
                .tag(2)
            }
            .accentColor(.orange)
            
            GeometryReader { geo in
                Image("add_fill")
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                    .position(x: (geo.size.width) * 0.5, y: geo.size.height - 35)
                    .onTapGesture {
//                        self.currentIndex = 1
                        self.isPopover = true
                }
            }
        }
    
        .sheet(isPresented: $isPopover) {
            AddView(vm: AddViewVM(phoneNum: "", code: ""))
        }
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
