//
//  SceneDelegate.swift
//  ImageSearch
//
//  Created by Jinho Jang on 2022/03/31.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let network = NetworkManager()
        let repository = ImageRepository(networkManager: network)
        let usecase = ImageUseCase(repository: repository)
        let vc = SearchViewController()
        let reactor = SearchReactor(usecase: usecase, presenter: vc)
        vc.reactor = reactor
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = UINavigationController(rootViewController: vc)
        window?.makeKeyAndVisible()
    }
}
