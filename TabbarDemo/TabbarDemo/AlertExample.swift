//
//  AlertExample.swift
//  TabbarDemo
//
//  Created by pgq on 2020/4/3.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI

struct AlertExample: View {
   @State private var showingAlert = false

    var body: some View {
        Button(action: {
            self.showingAlert = true
        }) {
            Text("Show Alert")
        }
        .alert(isPresented: $showingAlert) {
            /**
             按钮有三种
             .default 普通那妞
             .destructive 红色
             .cancel() 取消按钮
             */
            Alert(
                title: Text("Are you sure you want to delete this?"),
                message: Text("There is no undo"),
                primaryButton: .destructive(Text("Delete")) {
                    print("Deleting...")
            }, secondaryButton: .cancel())
        }
    }
}

/**
 请注意一点，如果你把两个alert放在了VStack中，那么只会有一个可以响应
 请注意一点，如果你把两个alert放在了VStack中，那么只会有一个可以响应
 请注意一点，如果你把两个alert放在了VStack中，那么只会有一个可以响应
 这也是下面代码为什么要这样子写的原因
 */
struct MultipleAlertExample: View {
    @State private var showingAlert1 = false
    @State private var showingAlert2 = false

    var body: some View {
        VStack {
            Button("Show 1") {
                self.showingAlert1 = true
            }
            .alert(isPresented: $showingAlert1) {
                Alert(title: Text("One"), message: nil, dismissButton: .cancel())
            }

            Button("Show 2") {
                self.showingAlert2 = true
            }
            .alert(isPresented: $showingAlert2) {
                Alert(title: Text("Two"), message: nil, dismissButton: .cancel())
            }
        }
    }
}
