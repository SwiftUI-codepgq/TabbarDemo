//
//  ActionSheetExample.swift
//  TabbarDemo
//
//  Created by pgq on 2020/4/3.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI

// 和Alert一样一样的，只是显示方式不同
struct ActionSheetExample: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button(action: {
            self.showingSheet = true
        }) {
            Text("Show Action Sheet")
        }
        .actionSheet(isPresented: $showingSheet) {
            ActionSheet(
                title: Text("What do you want to do?"),
                message: Text("There's only one choice..."),
                buttons: [.default(Text("Dismiss Action Sheet"))])
        }
    }
}



struct MultipleActionSheetExample: View {
    @State private var showingSheet1 = false
    @State private var showingSheet2 = false
    
    var body: some View {
        List {
            Button(action: {
                self.showingSheet1 = true
            }) {
                Text("Show Action Sheet")
            }
            .actionSheet(isPresented: $showingSheet1) {
                ActionSheet(
                    title: Text("1 What do you want to do?"),
                    message: Text("1 There's only one choice..."),
                    buttons: [.default(Text("Dismiss Action Sheet"))])
            }
            Button(action: {
                self.showingSheet2 = true
            }) {
                Text("Show Action Sheet")
            }
            .actionSheet(isPresented: $showingSheet2) {
                ActionSheet(
                    title: Text("2 What do you want to do?"),
                    message: Text("2 There's only one choice..."),
                    buttons: [.default(Text("Dismiss Action Sheet"))])
            }
        }
    }
}
