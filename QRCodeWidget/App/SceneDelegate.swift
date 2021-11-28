//
//  SceneDelegate.swift
//  QRCodeWidget
//
//  Created by Ilya Cherkasov on 28.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let vc = MainScreenBuilder.build()
        let nv = UINavigationController()
        
        window?.rootViewController = nv
        window?.makeKeyAndVisible()
        
        nv.pushViewController(vc, animated: true)
    }

}

