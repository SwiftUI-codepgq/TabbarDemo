//
//  UIApplication.swift
//  TabbarDemo
//
//  Created by pgq on 2020/3/30.
//  Copyright © 2020 pq. All rights reserved.
//

import UIKit
import SwiftUI

extension View {
    func changeRootView<Content>(view: Content) where Content : View {
        if  let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let windowScenedelegate = scene.delegate as? SceneDelegate {
            
           let window = UIWindow(windowScene: scene)
           window.rootViewController = UIHostingController(rootView: view)
           windowScenedelegate.window = window
           window.makeKeyAndVisible()
        }
    }
}
