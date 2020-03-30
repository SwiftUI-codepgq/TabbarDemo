//
//  HomeView.swift
//  TabbarDemo
//
//  Created by pgq on 2020/3/30.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                Text("Hello, World!, HomeView")                
            }
            .navigationBarTitle("Home  隐藏多余分割线", displayMode: .inline)
            
        }
        .onAppear {
            // 只移除多余的横线
            UITableView.appearance().tableFooterView = UIView()
        }
        .onDisappear {
            // 恢复
            UITableView.appearance().tableFooterView = nil
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
