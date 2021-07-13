//
//  SceneDelegate.swift
//  BooksRecorder
//
//  Created by Никита Гусев on 13.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        guard let navigator = DependencyContainer.shared.container.resolve(INavigator.self),
              let launchNavigationItem = navigator.launch()
        else { return }
        window.rootViewController = launchNavigationItem.viewController
        window.makeKeyAndVisible()
        self.window = window
    }
}

