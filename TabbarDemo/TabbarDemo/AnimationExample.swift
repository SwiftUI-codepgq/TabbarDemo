//
//  AnimationExample.swift
//  TabbarDemo
//
//  Created by pgq on 2020/4/7.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI
// MARK: - 动画基本介绍
struct AnimationExample: View {
    struct AnimationBtn: View {
        let title: String
        let animation: Animation?
        
        @State private var scale: CGFloat = 1
        
        var body: some View {
            HStack {
                Text(title)
                Spacer()
                Button(action: {
                    if self.scale == 2 {
                        self.scale = 1
                    } else if self.scale == 1 {
                        self.scale = 2
                    }
                }) {
                    Text("Tap here")
                        .scaleEffect(scale)
                        .animation(animation)
                }
            }.padding()
        }
    }
    
    var body: some View {
        Form {
            AnimationBtn(title: "liner",animation: .linear(duration: 0.25))
            AnimationBtn(title: "easeIn",animation: .easeIn)
            AnimationBtn(title: "easeOut",animation: .easeOut)
            AnimationBtn(title: "easeInOut",animation: .easeInOut)
            AnimationBtn(title: "timingCurve",animation: .timingCurve(0.1, 0.1, 0.6, 0.6, duration: 2))
            AnimationBtn(title: "sping",animation: .spring())
            AnimationBtn(title: "interpolatingSpring",animation: .interpolatingSpring(mass: 0.6, stiffness: 0.7, damping: 0.5, initialVelocity: 1))
            AnimationBtn(title: "Delay 1s", animation: Animation.linear.delay(1))
            
        }
    }
}


// MARK: - Bind Animation
struct BindValueAnimationExample: View {
    @State private var showingWelcome = false

    var body: some View {
        VStack {
            Toggle(isOn: $showingWelcome.animation(.linear(duration: 1))) {
                Text("Toggle label")
            }

            if showingWelcome {
                Text("Hello World")
            }
        }.padding()
    }
}

// MARK: - 显示动画
struct WithAnimationExample: View {
    struct DetailView: View {
        var body: some View {
            Image("ad")
            .resizable()
            .scaledToFill()
        }
    }
    
    @State private var opacity = 1.0
    @State private var isPresent = false
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.linear(duration: 2)) {
                    self.opacity -= 0.2
                    self.isPresent = true
                }
            }) {
                Text("Tap here")
                    .padding()
                    .opacity(opacity)
            }
        }.sheet(isPresented: $isPresent) {
            DetailView()
        }
    }
}

// MARK: - 页面加载之后马上出现动画
struct OnAppearAnimationExample: View {
    @State var scale: CGFloat = 1

       var body: some View {
           Circle()
            .scaleEffect(scale)
            .animateForever(autoreverses: true) { self.scale = 0.5 }
       }
}

// 下面代码是对View的扩展，方便我们在视图加载的时候就使用用动画
extension View {
    func animate(using animation: Animation = Animation.easeInOut(duration: 1), _ action: @escaping () -> Void) -> some View {
        return onAppear {
            withAnimation(animation) {
                action()
            }
        }
    }
}

extension View {
    func animateForever(using animation: Animation = Animation.easeInOut(duration: 1), autoreverses: Bool = false, _ action: @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: autoreverses)

        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}


// MARK: - 控制某个视图的动画，那些可以使用动画，那些不用
struct ControlAnimationExample: View {
    @State var isEnabled = false

    var body: some View {
        Button("Tap Me") {
            self.isEnabled.toggle()
        }
        .foregroundColor(.white)
        .frame(width: 200, height: 200)
        .background(isEnabled ? Color.green : Color.red)
        .animation(nil)
        .clipShape(RoundedRectangle(cornerRadius: isEnabled ? 100 : 0))
        .animation(.default)
    }
}
