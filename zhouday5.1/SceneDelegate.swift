//
//  SceneDelegate.swift
//  zhouday5.1
//
//  Created by zjs on 2026/1/8.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        // 设置 HomeViewController 为根视图控制器
        window.rootViewController = HomeViewController()
        
        self.window = window
        window.makeKeyAndVisible()
    }

}

