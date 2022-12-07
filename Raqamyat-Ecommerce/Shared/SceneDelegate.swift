//
//  SceneDelegate.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var rootController: UINavigationController {
        return self.window!.rootViewController as! UINavigationController
    }
    
    private lazy var applicationCoordinator: AnyCoordinator = self.createApplicationCoordinator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = createMainWidow(with: windowScene)
        applicationCoordinator.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }

}

extension SceneDelegate {
    
    private func createMainWidow(with windowScene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        let rootController = UINavigationController()
        window.rootViewController = rootController
        window.makeKeyAndVisible()
        return window
    }
    
    private func createApplicationCoordinator() -> AnyCoordinator {
        let router = WeakRouter(rootController: rootController)
        let coordinatorsFactory = CoordinatorFactory()
        let applicationCoordinator = ApplicationCoordinator(coordinatorFactory: coordinatorsFactory, router: router)
        return applicationCoordinator
    }
}
