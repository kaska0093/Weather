//
//  SceneDelegate.swift
//  Weather App
//
//  Created by Nikita Shestakov on 03.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.windowScene = scene
        
        let controller = MainViewController(manager: HelperManager())
        let view = MainView()
        let model = ModelManager()
        
        controller.itemsView = view
        controller.itemsView?.controller = controller
        
        controller.itemsModel = model
        controller.itemsModel?.controller = controller
        
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }
}

