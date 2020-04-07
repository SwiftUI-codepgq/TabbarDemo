//
//  TransitionAnimationExample.swift
//  TabbarDemo
//
//  Created by pgq on 2020/4/7.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI
// MARK: - 转场 动画
struct TransitionAnimationExample: View {
    struct TransitionView: View {
        let title: String
        let transition: AnyTransition
        @State private var showDetails = false

        var body: some View {
            HStack {
                Text(title)
                Spacer()
                VStack {
                    Button(action: {
                        withAnimation {
                            self.showDetails.toggle()
                        }
                    }) {
                        Text(showDetails ? "Tap to hide details" : "Tap to show details")
                    }

                    if showDetails {
                        Text("Details go here.")
                        .transition(transition)
                    }
                }
            }
                .padding(.leading)
                .padding(.trailing)
        }
    }
    
    var body: some View {
        List {
            TransitionView(title: "move", transition: .move(edge: .leading))
            TransitionView(title: "slide", transition: .slide)
            TransitionView(title: "scale", transition: .scale)
            TransitionView(title: "opacity", transition: .opacity)
            TransitionView(title: "offet", transition: .offset())
            TransitionView(title: "asymmetric", transition: .asymmetric(insertion: .slide, removal: .scale))
            TransitionView(title: "combine", transition: AnyTransition.move(edge: .top).combined(with: .opacity).combined(with: .scale))
        }
    }
}

// MARK: - 自定义转场动画
/**
 1 创建一个ViewModifier代表您处于任何状态的过渡的。
 2 创建一个AnyTransition扩展，将您的视图修饰符用于活动状态和身份状态。
 3 使用transition()修饰符将该过渡应用于视图。
 */
struct CustomTransionExample: View {
    // 创建一个圆形出来，并向外暴露一个参数，用来控制圆形的填充大小
    struct ScaledCircle: Shape {
        var animatableData: CGFloat

        func path(in rect: CGRect) -> Path {
            let maximumCircleRadius = sqrt(rect.width * rect.width + rect.height * rect.height)
            let circleRadius = maximumCircleRadius * animatableData

            let x = rect.midX - circleRadius / 2
            let y = rect.midY - circleRadius / 2

            let circleRect = CGRect(x: x, y: y, width: circleRadius, height: circleRadius)

            return Circle().path(in: circleRect)
        }
    }
    
    // 新建一个ViewModifier，等下调用的时候会使用
    struct ClipShapeModifier<T: Shape>: ViewModifier {
        let shape: T

        func body(content: Content) -> some View {
            content.clipShape(shape)
        }
    }
    
    // 新建一个转场动画
    static var iris: AnyTransition {
        .modifier(
            active: ClipShapeModifier(shape: ScaledCircle(animatableData: 0)),
            identity: ClipShapeModifier(shape: ScaledCircle(animatableData: 1))
        )
    }
    
    @State private var isShowingRed = false

    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 300, height: 300)

                if isShowingRed {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 300, height: 300)
                        .transition(CustomTransionExample.iris)
                        .zIndex(1)
                }
            }
            .navigationBarItems(trailing: Button("Switch") {
                withAnimation(.easeInOut) {
                    self.isShowingRed.toggle()
                }
            })
        }
    }
}
