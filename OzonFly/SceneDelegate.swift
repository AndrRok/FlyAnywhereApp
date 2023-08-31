//
//  SceneDelegate.swift
//  OzonFly
//
//  Created by ARMBP on 8/29/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navController = UINavigationController(rootViewController: ExplorerVC())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}

