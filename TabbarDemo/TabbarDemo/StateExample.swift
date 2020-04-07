//
//  StateExample.swift
//  TabbarDemo
//
//  Created by pgq on 2020/4/2.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI
import Combine

/**
 @State
 @ObservedObject
 @EnvironmentObject
 三者的区别
 
 @State 通常用在具体的某一个View中，例如我们的登录页面中的是否显示密码，他通常应该被标记为private，另外的View可以对她进行访问和修改
 @ObservedObject 相较于@State，他的使用场景倾向于多个页面之前数据的传递，还是用登录页面中展示，假设你再登录页面进行登录的时候，忘记密码了，此时你需要找回密码，这个时候进入找回密码页面，很多App进入这个页面的时候，会把在登录页面的账户进行传递过来，避免用户再次数据账户，类似于这种情况就可以使用@ObservedObject
 @EnvironmentObject 相较于上面两个，这个家伙管理能力最强，他通常用来共享数据，还是用登录进行举例，通常我们登录成功之后会得到一个token，我们可能需要在不同的页面发起不同的网络情况，这种时候我们就可以考虑使用@EnvironmentObject来进行数据之间的共享，使用这个的时候，需要在SceneDelegate中进行设置，调用View的modifier方法`environmentObject(xx)`，使用这个的好处就是，你在根视图注册了之后，在任意一个地方都可以进行访问，只要你是从根视图往下展示的View，很类似于Flutter的provider方案
 */

struct StateExample: View {
    @State private var isShowText = false
    
    var body: some View {
        List {
            Toggle(isOn: $isShowText) {
                Text("是否显示文本")
            }
            
            if isShowText {
                Text("你要显示我？？？")
            }
        }
    }
}



struct ObservedObjectExample: View {
    
    // 定义一个类
    class UserSettings: ObservableObject {
        @Published var score = 0
    }
    
    // 使用@ObservedObject进行修饰
    @ObservedObject var settings = UserSettings()

    var body: some View {
        VStack {
            Text("Your score is \(settings.score)")
            Button(action: {
                self.settings.score += 1
            }) {
                Text("Increase Score")
            }
            
            NavigationLink(destination: ObservedObjectExample(settings: settings)) {
                Text("进入二级页面")
            }
        }
    }
}


struct PublishedExample {
    
   class UserAuthentication: ObservableObject {
        let objectWillChange = ObservableObjectPublisher()

        var username = "" {
            willSet {
                objectWillChange.send()
            }
        }
    }
    
    @ObservedObject var settings = UserAuthentication()

    var body: some View {
        VStack {
            TextField("Username", text: $settings.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Text("Your username is: \(settings.username)")
        }
    }
}


/** 使用这个的时候比较特殊，一定要记得在SceneDelegate 修改为如下代码，否则程序运行会奔溃！！！！
 ```
 var settings = EnvironmentObjectExample.UserSettings()
 window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(settings))
 ```
 */
struct EnvironmentObjectExample: View {
    class UserSettings: ObservableObject {
        @Published var score = 0
    }
    
    struct DetailView: View {
        var body: some View {
            Text("This is detail view")
        }
        
    }
    
    @EnvironmentObject var settings: UserSettings

    var body: some View {
        NavigationView {
            VStack {
                // A button that writes to the environment settings
                Button(action: {
                    self.settings.score += 1
                }) {
                    Text("Increase Score")
                }

                NavigationLink(destination: DetailView()) {
                    Text("Show Detail View")
                }
            }
        }
    }
}


// 绑定一个常量, constant 支持 bool、string、float、int
struct BindConstantExample: View {
    var body: some View {
        List {
            Toggle(isOn: .constant(true)) {
                Text("Show advanced options")
            }
            
            TextField("", text: .constant("不能改变的文字"))
            
            Slider(value: .constant(0.3))
        }
    }
}

// 自定义binding
struct DIYBindExample1: View {
    @State private var name: String = ""
    var body: some View {
        let text = Binding(
            get: { self.name },
            set: { (newValue) in
                if newValue.count <= 11 {
                    self.name = newValue
                }
            })
        
        return VStack {
            TextField("Enter your name", text: text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
                .border((text.wrappedValue.count == 11) ? Color.green : Color.red)
            
            Text(text.wrappedValue)
        }
        .padding()
    }
}

struct DIYBindExample2: View {
    @State private var firstToggle = false
    @State private var secondToggle = false

    var body: some View {
        let firstBinding = Binding(
            get: { self.firstToggle },
            set: {
                self.firstToggle = $0

                if $0 == true {
                    self.secondToggle = false
                }
            }
        )

        let secondBinding = Binding(
            get: { self.secondToggle },
            set: {
                self.secondToggle = $0

                if $0 == true {
                    self.firstToggle = false
                }
            }
        )

        return VStack {
            Toggle(isOn: firstBinding) {
                Text("First toggle")
            }

            Toggle(isOn: secondBinding) {
                Text("Second toggle")
            }
        }
        .padding()
    }
}

// 但是有问题，第二次进入这个页面,定时器不会启动，如果想，参考AddView
struct TimerExample: View {
    @State var timeRemaining = 10
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text("\(timeRemaining)")
            .onReceive(timer) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
            }
    }
}
