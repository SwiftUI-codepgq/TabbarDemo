//
//  ViewExample.swift
//  TabbarDemo
//
//  Created by pgq on 2020/4/2.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI
// MARK: - Text UILabel
struct TextExample: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - toggle UISwitch
struct ToggleExample: View {
    @State private var showGreeting = true

    var body: some View {
        VStack {
            Toggle(isOn: $showGreeting) {
                Text("Show welcome message")
            }.padding()

            if showGreeting {
                Text("Hello World!")
            }
        }
    }
}

// MARK: - Button
struct ButtonExample: View {
    var body: some View {
        List {
            EditButton()
            Button(action: {
                // your action here
            }) {
                Image(systemName: "play")
            }
            .buttonStyle(PlainButtonStyle())
            
            NavigationLink(destination: Text("Detail view here")) {
                Image(systemName: "play.fill    ")
                    .renderingMode(.original)
            }
            
            NavigationLink(destination: Text("Detail view here")) {
                Image(systemName: "play.fill    ")
                    .renderingMode(.original)
            }
            .buttonStyle(PlainButtonStyle())
            
        }
    }
}

// MARK: - TextField
struct TextFieldExample: View {
    @State private var emailAddress = ""
    @State private var password = ""

    var body: some View {
        List {
            TextField("johnnyappleseed@apple.com", text: $emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                // 关闭拼写检查
                .disableAutocorrection(true)
            
            SecureField("please enter your password", text: $password)
        }
        .padding()
    }
}

// MARK: - Slider
struct SliderExample: View {
    @State private var celsius: Double = 0

    var body: some View {
        VStack {
            Slider(value: $celsius, in: -100...100, step: 0.1)
            Text("\(celsius) Celsius is \(celsius * 9 / 5 + 32) Fahrenheit")
        }
    }
}

// MARK: - Picker
struct SimplePickerExample: View {
   var colors = ["Red", "Green", "Blue", "Tartan"]
   @State private var selectedColor = 0

   var body: some View {
      VStack {
         Picker(selection: $selectedColor, label: Text("Please choose a color")) {
            ForEach(0 ..< colors.count) {
               Text(self.colors[$0])
            }
         }
         Text("You selected: \(colors[selectedColor])")
      }
   }
}

/// date picker
struct DatePickerExample: View {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

    @State private var birthDate = Date()

    var body: some View {
        VStack {
            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                Text("Select a date")
            }

            Text("Date is \(birthDate, formatter: dateFormatter)")
        }
    }
}


struct SegmentedPickerExample: View {
    @State private var favoriteColor = 0
    var colors = ["Red", "Green", "Blue"]

    var body: some View {
        VStack {
            Picker(selection: $favoriteColor, label: Text("What is your favorite color?")) {
                ForEach(0..<colors.count) { index in
                    Text(self.colors[index]).tag(index)
                }
            }.pickerStyle(SegmentedPickerStyle())

            Text("Value: \(colors[favoriteColor])")
        }
    }
}

// MARK: - Stepper
struct StepperExample: View {
    @State private var age = 18

    var body: some View {
        VStack {
            Stepper("Enter your age", onIncrement: {
                self.age += 1
                print("Adding to age")
            }, onDecrement: {
                self.age -= 1
                print("Subtracting from age")
            })

            Text("Your age is \(age)")
        }
    }
}

// MARK: - Gesture
/// 点击
struct TapExample: View {
    var body: some View {
        List {
            
            // 单击
            Rectangle()
                .background(Color.red)
                .frame(height: 40)
                .onTapGesture {
                    
            }
            
            // 双击
            Rectangle()
                .background(Color.green)
                .frame(height: 40)
                .onTapGesture(count: 2) {
                    
            }
            
            
            // 使用.contentShape()控制点击区域
            Rectangle()
            .background(Color.green)
                .frame(width: 60, height: 60, alignment: .center)
                .contentShape(Circle())
                .onTapGesture(count: 2) {
                    
            }
            
        }
    }
}

struct GestureExample: View {
    @State private var scale: CGFloat = 1.0

    var body: some View {
        List {
            Image("add")
                .scaleEffect(scale)

                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            self.scale += 0.1
                        }
                )
            
            Image("add")
            .gesture(
                LongPressGesture(minimumDuration: 2)
                    .onEnded { _ in
                        print("Pressed!")
                }
            )
            
            Image("add")
            .gesture(
                DragGesture(minimumDistance: 50)
                    .onEnded { _ in
                        print("Dragged!")
                    }
            )
        }
    }
}

// MARK: - 隐藏视图 labelsHidden 可以隐藏PickerView的标题
struct HiddenViewExample: View {
    @State private var selectedNumber = 0
    var body: some View {
        Picker("Select a number", selection: $selectedNumber) {
            ForEach(0..<10) {
                Text("\($0)")
            }
        }
        .labelsHidden()
    }
    
}

// MARK: - 控制响应链
struct HitTestExample: View {
    var body: some View {
        ZStack {
            Button("Tap Me") {
                print("Button was tapped")
            }
            .frame(width: 100, height: 100)
            .background(Color.white)

            Rectangle()
                .fill(Color.red.opacity(0.2))
                .frame(width: 300, height: 300)
                .clipShape(Circle())
                // 当前的矩形将不会收到任何事件
                .allowsHitTesting(false)
        }
    }
}

// MARK: - Hover 悬停
@available(iOS 13.4, *)
struct HoverExample: View {
    @State private var overText = false
    

    
    var body: some View {
        List {
            Text("Hello, World!")
                .foregroundColor(overText ? Color.green : Color.red)
                .onHover { over in
                    self.overText = over
            }
            
            Text("Tap me!")
            .font(.largeTitle)
            .hoverEffect(.lift)
            .onTapGesture {
                print("Text tapped")
            }
        }
    }
}

// MARK: - List 列表部分，UITableView
struct StaticListExample: View {
    var body: some View {
        List {
            Text("1111")
            Text("2222")
            Text("3333")
            Text("4444")
        }
        
    }
}

struct DynamicListExample: View {
    var body: some View {
        List(1...5, id: \.self) {
            Text("index \($0)")
        }
    }
}

struct DeleteListExample: View {
    @State private var users = ["Paul", "Taylor", "Adele"]

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    Text(user)
                }
                .onDelete(perform: delete)
            }
        }
    }

    func delete(at offsets: IndexSet) {
        users.remove(atOffsets: offsets)
    }
    
    func move(indexSet: IndexSet, offset: Int) {
        users.move(fromOffsets: indexSet, toOffset: offset)
    }
}

struct MoveListExample: View {
    @State private var users = ["Paul", "Taylor", "Adele"]

    var body: some View {
        NavigationView {
            List {
                ForEach(users, id: \.self) { user in
                    Text(user)
                }
                .onMove(perform: move)
            }
             .navigationBarItems(trailing: EditButton())
        }
    }
    
    func move(indexSet: IndexSet, offset: Int) {
        users.move(fromOffsets: indexSet, toOffset: offset)
    }
}


struct SectionListExample: View {
    struct TaskRow: View {
        var body: some View {
            Text("Task data goes here")
        }
    }
    var body: some View {
        List {
            Section(header: Text("Important tasks").background(Color.yellow)) {
                TaskRow()
                TaskRow()
                TaskRow()
            }

            Section(footer: Text("Other tasks").background(Color.blue)) {
                TaskRow()
                TaskRow()
                TaskRow()
            }
            
            Section(header: Text("Other tasks").background(Color.yellow), footer: Text("End").background(Color.blue)) {
                TaskRow()
                TaskRow()
                TaskRow()
            }
        }
        .listStyle(GroupedListStyle())
//        .listStyle(PlainListStyle())
    }
}


struct ListRowBackgroundExample: View {
    var body: some View {
        List {
            ForEach(0..<10) {
                Text("Row \($0)")
            }
//            .listRowBackground(Color.red)
                .listRowBackground(LinearGradient(gradient: Gradient(colors: [.purple, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
//                .listRowBackground(Image("ad").resizable().scaledToFit())
        }
    }
}

struct ListMoreViewRowExample: View {
    struct User: Identifiable {
        var id = UUID()
        var username = "Anonymous"
    }
    
    let users = [User(), User(), User()]

    var body: some View {
        List(users) { user in
            Image(systemName: "heart")
                .font(.largeTitle)
            Text(user.username)
        }
    }
}

// MARK: - Form部分
struct FormExample: View {
    @State private var enableLogging = false

    @State private var selectedColor = 0
    @State private var colors = ["Red", "Green", "Blue"]

    /**
     Form 和 VStack很像， 但是From会自动适应某些控件的行为和样式
     可以依次控制注释行，看看效果有什么不同
     他和Stack一样，子视图都可以超过10个
     */
    var body: some View {
        NavigationView {
            Form {
//            VStack {
                Picker(selection: $selectedColor, label: Text("Select a color")) {
                    ForEach(0 ..< colors.count) {
                        Text(self.colors[$0]).tag($0)
                    }
                }.pickerStyle(SegmentedPickerStyle())

                Toggle(isOn: $enableLogging) {
                    Text("Enable Logging")
                }

                Button(action: {
                // activate theme!
                }) {
                    Text("Save changes")
                }
            }.navigationBarTitle("Settings")
        }
    }
}

struct SectionFormExample: View {
    @State private var enableLogging = false

    @State private var selectedColor = 0
    @State private var colors = ["Red", "Green", "Blue"]

    var body: some View {
        NavigationView {
            Form {
                Section(footer: Text("Note: Enabling logging may slow down the app")) {
                    Picker(selection: $selectedColor, label: Text("Select a color")) {
                        ForEach(0 ..< colors.count) {
                            Text(self.colors[$0]).tag($0)
                        }
                    }.pickerStyle(SegmentedPickerStyle())

                    Toggle(isOn: $enableLogging) {
                        Text("Enable Logging")
                    }
                }

                Section {
                    Button(action: {
                    // activate theme!
                    }) {
                        Text("Save changes")
                    }
                }
            }.navigationBarTitle("Settings")
        }
    }
}


struct FormPickerExample: View {
    var strengths = ["Mild", "Medium", "Mature"]

    @State private var selectedStrength = 0

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $selectedStrength, label: Text("Strength")) {
                        ForEach(0 ..< strengths.count) {
                            Text(self.strengths[$0])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Picker(selection: $selectedStrength, label: Text("Strength")) {
                        ForEach(0 ..< strengths.count) {
                            Text(self.strengths[$0])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }.navigationBarTitle("Select your cheese")
            
        }
    }
}

// MARK: - 控制视图的disable/enable
struct DisableExample: View {
    @State private var agreedToTerms = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Toggle(isOn: $agreedToTerms) {
                        Text("Agree to terms and conditions")
                    }
                }

                Section {
                    Button(action: {
                        // show next screen here
                    }) {
                        Text("Continue")
                    }.disabled(!agreedToTerms)
                }
            }.navigationBarTitle("Welcome")

        }
    }
}

// MARK: - if ...  if ... esle ... 语句的使用
struct ShowMoreViewExample: View {
    @State private var showingAdvancedOptions = false
    @State private var enableLogging = false

    var body: some View {
        Form {
            Section {
                Toggle(isOn: $showingAdvancedOptions.animation()) {
                    Text("Show advanced options")
                }

                if showingAdvancedOptions {
                    Toggle(isOn: $enableLogging) {
                        Text("Enable logging")
                    }
                }
            }
        }
    }
}

// MARK: - 导航栏部分
/**
 使用.navigationBatItems的时候要注意，如果想要设置左边和右边的navigationBarItems
 一定要使用.navigationBarItems(leading: View, trailing: View)方法，否则会出现只显示一边的问题
 */
struct NavigationViewExample: View {
    var body: some View {
        NavigationView {
            Text("SwiftUI")
                
            // inline 就是在导航栏中， large就是有动画的（参考苹果的设置界面）
            .navigationBarTitle("Welcome", displayMode: .inline)
            
                //  右边导航栏标题列表
            .navigationBarItems(trailing:
                HStack {
                    Button("About") {
                        print("About tapped!")
                    }

                    Button("Help") {
                        print("Help tapped!")
                    }
                }
            )
            
                // 左边导航栏标题列表
//            .navigationBarItems(leading:
//                HStack {
//                    Button("back") {
//                        print("back tapped!")
//                    }
//
//                    Button("More") {
//                        print("More tapped!")
//                    }
//                }
//            )
        }
    }
}

struct NavigationLinkExample: View {
    struct DetailView: View {
        var body: some View {
            Text("This is the detail view")
        }
    }
    
     var body: some View {
           NavigationView {
               VStack {
                   NavigationLink(destination: DetailView()) {
                       Text("Show Detail View")
                   }.navigationBarTitle("Navigation")
               }
           }
       }
}

struct NavigationLinkListExample: View {
    struct Restaurant: Identifiable {
        var id = UUID()
        var name: String
    }
    
    struct RestaurantRow: View {
        var restaurant: Restaurant

        var body: some View {
            Text(restaurant.name)
        }
    }
    
    struct RestaurantView: View {
        var restaurant: Restaurant

        var body: some View {
            Text("Come and eat at \(restaurant.name)")
                .font(.largeTitle)
        }
    }
    
    var body: some View {
        let first = Restaurant(name: "Joe's Original")
        let restaurants = [first]

        return NavigationView {
            List(restaurants) { restaurant in
                NavigationLink(destination: RestaurantView(restaurant: restaurant)) {
                    RestaurantRow(restaurant: restaurant)
                }
            }.navigationBarTitle("Select a restaurant")
        }
    }
}

// MARK: - Tab 的使用，类似UITabBarController
struct TabViewExample: View {
   @State private var currentIndex: Int = 0
        @State private var isPopover = false
        var body: some View {
            ZStack {
                TabView(selection: $currentIndex) {
                    Text("主页")
                        .tabItem {
                            homeImage
                            Text("主页")
                    }
                    .tag(0)
                    
                    Text("自定义")
                        .tabItem {
                            Text("")
                            .disabled(true)
                    }.tag(1)
                    
                    Text("个人中心")
                        .tabItem {
                            mineImage
                            Text("我的")
                    }
                    .tag(2)
                }
                .accentColor(.orange)
                
                GeometryReader { geo in
                    Image("add_fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                        .position(x: (geo.size.width) * 0.5, y: geo.size.height - 35)
                        .onTapGesture {
    //                        self.currentIndex = 1
                            self.isPopover = true
                    }
                }
            }
        
            .sheet(isPresented: $isPopover) {
                Text("自定义")
            }
        }
        
        private var mineImage: some View {
            let name = currentIndex == 1 ? "person.fill" : "person"
            return Image(systemName: name)
        }
        
        private var homeImage: some View {
            let name = currentIndex == 0 ? "house.fill" : "house"
            return Image(systemName: name)
        }
}


// MARK: - Group的使用
struct GroupExample: View {
    var body: some View {
        VStack {
            Group {
                Text("Line")
                Text("Line")
                Text("Line")
                Text("Line")
                Text("Line")
                Text("Line")
            }

            Group {
                Text("Line")
                Text("Line")
                Text("Line")
                Text("Line")
                Text("Line")
            }
        }
    }
}

// MARK: - 隐藏状态栏
struct HiddenStatusBarExample: View {
    @State var hideStatusBar = false

    var body: some View {
        Button("Toggle Status Bar") {
            withAnimation {
                self.hideStatusBar.toggle()
            }
        }
        .statusBar(hidden: hideStatusBar)
    }
}

// MARK: - 调整视图位置
struct PositionExample: View {
    var body: some View {
        ZStack {
            Text("Home")
            Text("Options")
                .offset(y: 15)
                .padding(.bottom, 15)
            Text("Help")
        }
    }
}

// MARK: - 调用顺序带来的影响！！！
struct ColorExample: View {
    var body: some View {
        List {
            Text("Hacking with Swift")
            .background(Color.black)
            .foregroundColor(.white)
            .padding()
            
            Text("Hacking with Swift")
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            
            Text("Forecast: Sun")
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.red)
            .padding()
            .background(Color.orange)
            .padding()
            .background(Color.yellow)
        }
    }
}

// MARK: - Border 边框
struct BorderExample: View {
    var body: some View {
        VStack(spacing: 5) {
            Text("Hacking with Swift")
            .border(Color.black)
            
            Text("Hacking with Swift")
            .padding()
            .border(Color.black)
            
            Text("Hacking with Swift")
            .padding()
            .border(Color.red, width: 4)
            
            Text("Hacking with Swift")
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.blue, lineWidth: 4)
            )
            
            Circle()
            .strokeBorder(Color.blue, lineWidth: 23)
                .background(Color.yellow)
            
            Circle()
            .stroke(Color.blue, lineWidth: 23)
            .background(Color.yellow)
        }
    }
}

// MARK: - 阴影
struct ShadowExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Hacking with Swift")
            .padding()
            .shadow(radius: 5)
            .border(Color.red, width: 4)
            
            Text("Hacking with Swift")
            .padding()
            .shadow(color: .red, radius: 5)
            .border(Color.red, width: 4)
            
            Text("Hacking with Swift")
            .padding()
            .shadow(color: .red, radius: 5, x: 20, y: 20)
            .border(Color.red, width: 4)
            
            Text("Hacking with Swift")
            .padding()
            .border(Color.red, width: 4)
            .shadow(color: .red, radius: 5, x: 20, y: 20)
        }
    }
}

// MARK: - 裁剪视图
struct ClipViewExample: View {
    var body: some View {
        Form {
            
            Button(action: {
                print("Button tapped")
            }) {
                Image(systemName: "bolt.fill")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .clipShape(Circle())
            }
            
            
            Button(action: {
                print("Button tapped")
            }) {
                Image(systemName: "bolt.fill")
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                    .background(Color.green)
                    .clipShape(Capsule())
            }
        }
    }
}

// MARK: - 旋转
struct RotationExample: View {
    @State private var rotation = 0.0

    var body: some View {
        VStack {
            Slider(value: $rotation, in: 0...360, step: 1.0)
            Text("Up we go center")
                .rotationEffect(.degrees(rotation))
            
            Text("Up we go topLeading")
                .rotationEffect(.degrees(rotation), anchor: .topLeading)
            Text("Up we go bottomTrailing")
            .rotationEffect(.degrees(rotation), anchor: .bottomTrailing)
            
            Text("EPISODE LLVM")
            .font(.largeTitle)
            .foregroundColor(.yellow)
            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 0, z: 0))
            
            Text("EPISODE LLVM")
            .font(.largeTitle)
            .foregroundColor(.yellow)
            .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
            
            Text("EPISODE LLVM")
            .font(.largeTitle)
            .foregroundColor(.yellow)
            .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 0, z: 1))
            
            Text("EPISODE LLVM")
            .font(.largeTitle)
            .foregroundColor(.yellow)
            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 0, z: 1))
        }.padding()
    }
}

// MARK: - Scale
struct ScaleExample: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Up we go")
            .scaleEffect(5)
            
            Text("Up we go")
            .scaleEffect(x: 1, y: 5)
            
            Text("Up we go")
            .scaleEffect(2, anchor: .bottomTrailing)
        }
    }
}

// MARK: - 圆角处理
struct CornerRadiusExample: View {
    var body: some View {
        Text("Round Me")
        .padding()
        .background(Color.red)
        .cornerRadius(25)
    }
}


// MARK: - opacity
struct OpacityExample: View {
    var body: some View {
        Text("Now you see me")
        .padding()
        .background(Color.red)
        .opacity(0.3)
    }
}

// MARK: - AccentColor
struct AccentColorExample: View {
    @State private var isOn = false
    
    var body: some View {
        VStack {
            Button(action: {}) {
                Text("Tap here")
            }
            
            Toggle(isOn: $isOn) {
                Text("DFD")
            }
            .accentColor(.blue)
        }.accentColor(.orange)
    }
}

// MARK: - 遮罩
struct MaskExample: View {
    var body: some View {
        Image("ad")
        .resizable()
        .frame(width: 300, height: 300)
        .mask(Text("SWIFT! ❤️")
            .font(Font.system(size: 72).weight(.black)))
    }
}

// MARK: - 模糊
struct BlurExample: View {
    var body: some View {
        ZStack {
            Image("ad")
            .resizable()
                .edgesIgnoringSafeArea(.all)
            .blur(radius: 20)
            
            Text("Welcome to my SwiftUI app")
                .foregroundColor(Color.white)
                .font(.body)
            .shadow(radius: 10)
//            .blur(radius: 2)
        }
    }
}

// MARK: - 混合模式
struct BlenModeExample: View {
    var body: some View {
        ZStack {
            Image("ad")
            Image("bg1")
                .blendMode(.multiply)
        }
    }
}

// MARK: - ColorMultiply
struct ColorMultiplyExample: View {
    let colors = [Color.red, Color.blue, Color.yellow]
    let titles = ["red", "blue", "yellow"]
    @State private var color = Color.red
    
    var body: some View {
        
        VStack {
            Picker(selection: $color, label: Text("Sel Color")) {
                ForEach(0 ..< colors.count) {
                    Text(self.titles[$0])
                        .foregroundColor(.white)
                        .background(self.colors[$0])
                }
            }.pickerStyle(SegmentedPickerStyle())
                
            Image("bg1")
                .resizable()
//                .scaledToFill()
//                .edgesIgnoringSafeArea(.all)
            .colorMultiply(color)
                .zIndex(1)
        }.padding()
    }
}
