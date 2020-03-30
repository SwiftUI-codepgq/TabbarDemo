//
//  MineView.swift
//  TabbarDemo
//
//  Created by pgq on 2020/3/30.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI

struct MineView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Hello, World!, MineView")
                Text("Hello, World!, MineView")
                Text("Hello, World!, MineView")
            }
                
            .navigationBarTitle("Mine 隐藏所有的分割线", displayMode: .inline)
        }
        .onAppear {
            // 移除所有的线
            UITableView.appearance().separatorStyle = .none
        }
        .onDisappear {
            // 恢复
            UITableView.appearance().separatorStyle = .singleLine
        }
    }
}

struct MineView_Previews: PreviewProvider {
    static var previews: some View {
        MineView()
    }
}
