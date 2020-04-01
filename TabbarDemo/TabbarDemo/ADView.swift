//
//  ADView.swift
//  TabbarDemo
//
//  Created by pgq on 2020/3/30.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI

struct ADView: View {
    @State private var countDown = 5
    @State private var time: String = "跳过广告 5s"
    @State private var timer: Timer?
    
    @EnvironmentObject var addVM: AddViewVM
    var body: some View {
        ZStack {
            Image("ad")
                .resizable()
//                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            GeometryReader { geo in
                Button(action: {
                    self.skipToHome()
                }) {
                    Text(self.time)
                    .foregroundColor(.white)
                    .frame(width: 120, height: 40)
                    .background(Color.gray.opacity(0.3))
                    .position(x: geo.size.width - 70, y: geo.safeAreaInsets.top)
                }
            }
            
        }
        .onAppear {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
                self.countDown -= 1
                if self.countDown < 0 {
                    self.skipToHome()
                    return
                }
                self.time = "跳过广告 \(self.countDown)s"
            })
        }
    }
    
    private func skipToHome() {
        self.timer?.invalidate()
        self.timer = nil
        
        changeRootView(view: ContentView().environmentObject(addVM))
    }
}

struct ADView_Previews: PreviewProvider {
    static var previews: some View {
        ADView()
    }
}
