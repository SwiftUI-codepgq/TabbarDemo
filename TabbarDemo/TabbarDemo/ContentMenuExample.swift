//
//  ContentMenuExample.swift
//  TabbarDemo
//
//  Created by pgq on 2020/4/3.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI

struct ContentMenuExample: View {
    @State private var text = "我是🐂"
    
    var body: some View {
        VStack {
            Text(text)
                .contextMenu {
                    Button(action: {
                        // change country setting
                        UIPasteboard.general.string = self.text
                    }) {
                        Text("Copy")
                        Image(systemName: "doc.on.doc")
                    }
                    
                    Button(action: {
                        // enable geolocation
                        self.text = ""
                    }) {
                        Text("Delete All")
                        Image(systemName: "trash")
                    }
            }
            
            Spacer().frame(height: 20)
            
            Button("Resume text") {
                self.text = "我是🐂"
            }
        }
    }
}
