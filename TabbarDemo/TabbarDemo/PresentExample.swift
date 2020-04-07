//
//  PresentExample.swift
//  TabbarDemo
//
//  Created by pgq on 2020/4/3.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI

struct PresentExample: View {
    struct DetailView: View {
        var body: some View {
            Text("Detail")
        }
    }
    
    @State var showingDetail = false

    var body: some View {
        Button(action: {
            self.showingDetail.toggle()
        }) {
            Text("Show Detail")
        }.sheet(isPresented: $showingDetail) {
            DetailView()
        }
    }
}


struct DismissSelfExample1: View {
    struct DetailView: View {
        @Environment(\.presentationMode) var presentationMode
        
        var body: some View {
            Text("Tap Me dismiss")
                .font(.largeTitle)
                .onTapGesture {
                    self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
    
    
    @State var showingDetail = false

    var body: some View {
        Button(action: {
            self.showingDetail.toggle()
        }) {
            Text("Show Detail")
        }.sheet(isPresented: $showingDetail) {
            DetailView()
        }
    }
}

struct DismissSelfExample2: View {
    struct DetailView: View {
        @Binding var showingNewUserView: Bool
        var body: some View {
            Text("Tap Me dismiss")
                .font(.largeTitle)
                .onTapGesture {
                    self.showingNewUserView = false
            }
        }
    }
    
    
    @State var showingDetail = false

    var body: some View {
        Button(action: {
            self.showingDetail.toggle()
        }) {
            Text("Show Detail")
        }.sheet(isPresented: $showingDetail) {
            DetailView(showingNewUserView: self.$showingDetail)
        }
    }
}
