//
//  AddView.swift
//  TabbarDemo
//
//  Created by pgq on 2020/3/31.
//  Copyright © 2020 pq. All rights reserved.
//

import SwiftUI
import Combine
import Foundation
import UIKit

struct AddView: View {
    @State var vm: AddViewVM
    @State private var timer: Timer?
    @State private var countDown = 60

    var body: some View {
        _ = vm.phone.sink { (text) in
            print("line 22", text)
        }
        return List {
            VStack {
                HStack {
                    Image(systemName: "phone.down.circle")
                        .rotationEffect(Angle(degrees: 90))
                    
                    TextField("请输入号码", text: $phone, onEditingChanged: { edit in
                    }, onCommit:  {
                    })
                        // 禁用自动更正（拼写检查）
                    .disableAutocorrection(true)
                   .frame(height: 40)
                        .onReceive(vm.$phone) { (string) in
                            
                    }
                       
                }
                Divider()
                if !vm.hintPhoneNum.value {
                    Text("手机号码应该是11位数字")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            
            VStack {
                HStack {
                    TextField("请输入号码", text: $vm.code, onEditingChanged: { edit in
                    }, onCommit: {
                    })
                    .frame(height: 40)
                    
                    Button(action: {
                          // get code
                       self.timer?.fireDate = Date.distantPast
                    }, label: {
                        Text((countDown == 60) ? "获取验证码" : "请\(countDown)s之后重试")
                    }).disabled(countDown != 60 ||
                    vm.phoneNum.value.count != 11)
                }
                Divider()
                if !vm.hintCode.value {
                    Text("请输入正确的验证码(4位数字)")
                        .font(.caption)
                        .foregroundColor(.red)
                        .frame(alignment: .top)
                }
                
            }
            
            Button(action: {
                print("login action", self.vm.phoneNum, self.vm.code)
            }) {
                Text("Login")
                    .foregroundColor(.white)
            }.frame(width: 100, height: 45, alignment: .center)
                .background(vm.canLogin.value ? Color.blue: Color.gray)
                .cornerRadius(10)
                .disabled(!vm.canLogin.value)
            
            Text(phone)
                .onReceive(vm.phone) { (string) in
                    print("string .... ", string)
                    
                    self.phone = string
            }
            Image(systemName: "cloud.heavyrain.fill")
            .font(.largeTitle)
            Image(systemName: "cloud.heavyrain.fill")
                .font(Font.system(size: 40))
            Spacer()
                .frame(height: 20)
           
            Button(action: {
                self.showCardView.toggle()
            }) {
                Text("CardView animation")
            }
            
            GridStack(rows: 4, columns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")
            }
            
            DismissKeyboardSpacer()
        }
        .sheet(isPresented: $showCardView, content: {
            CardView()
        })
        .onAppear {
            self.createTimer()
        }
        .onDisappear {
            self.invalidate()
        }
        .padding()
        
    }
    @State var showCardView: Bool = false
    @State var phone: String = ""
    
    private func createTimer() {
       if timer == nil {
           timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
               if self.countDown < 0 {
                   self.countDown = 0
                   t.invalidate()
               }
               self.countDown -= 1
           })
           // 先不触发定时器
           timer?.fireDate = .distantFuture
       }
    }
    
    private func invalidate() {
       timer?.invalidate()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(vm: AddViewVM(phoneNum: "", code: ""))
    }
}

final class AddViewVM: ObservableObject {
    /// 手机号
    @Published var phoneNum = CurrentValueSubject<String, Never>("")
    @Published var phone = PassthroughSubject<String, Never>()
    /// 验证码
    @Published var code: String = ""
    /// 是否显示请输入正确的手机号
    @Published var hintPhoneNum = CurrentValueSubject<Bool, Never>(false)
    /// 是否显示请输入正确的验证码
    @Published var hintCode = CurrentValueSubject<Bool, Never>(false)
    /// 是否可以登录
    @Published var canLogin = CurrentValueSubject<Bool, Never>(false)
    
    private var disposables = Set<AnyCancellable>()
    /// name default is ""
    init(phoneNum: String,
         code: String) {
        self.phoneNum = CurrentValueSubject<String, Never>(phoneNum)
       $phoneNum
        .dropFirst(1)
//        .filter { $0.count <= 11 }1
            .sink(receiveCompletion: { (string) in
                print("接收完成", string)
            }) { (string) in
                print("接收字符串", string)
               
                self.phone.send(string.value)
                self.phoneNum.send(string.value)
                if string.value.count > 11 {
                    
                    let text = try! string.value.substring(loc: 0, length: 10)
                    self.phone.send(text)
                    self.phoneNum.send(text)
                }
        }.store(in: &disposables)
    }
}

extension String {
    func substring(loc: Int, length: Int) throws -> String  {
        if (loc + length) >= self.count {
            throw NSError(domain: "out of range", code: 0, userInfo: ["info": "loc+length大于字符串长度"])
        }
        let startIndex = self.index(self.startIndex, offsetBy: loc)
        let endIndex = self.index(startIndex, offsetBy: length)
        
        return String(self[startIndex...endIndex])
    }
}


struct CardView: View {
    @State var dragAmount = CGSize.zero

    var body: some View {
        VStack {
            GeometryReader { geo in
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(width: 300, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .rotation3DEffect(.degrees(-Double(self.dragAmount.width) / 20), axis: (x: 0, y: 1, z: 0))
                    .rotation3DEffect(.degrees(Double(self.dragAmount.height / 20)), axis: (x: 1, y: 0, z: 0))
                    .offset(self.dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged { self.dragAmount = $0.translation }
                            .onEnded { _ in
                                withAnimation(.spring()) {
                                    self.dragAmount = .zero
                                }
                            }
                    )
            }
        }
    }
}


struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack {
                    ForEach(0 ..< self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }

    init(rows: Int, columns: Int, @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
}
