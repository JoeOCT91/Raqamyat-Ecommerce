//
//  ApplicationCoordinator.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import UIKit
import Combine

fileprivate var splashHasBeenShowed: Bool = true

fileprivate enum LaunchInstructor {
    case splash, main
    
    static func configure(isSplashWasShown: Bool = splashHasBeenShowed) -> LaunchInstructor {
        switch (isSplashWasShown) {
        case (false):
            return .splash
        case (true):
            return .main
        }
    }
}

final class ApplicationCoordinator: BaseCoordinator {
    
    private let coordinatorFactory: ApplicationCoordinatorFactory
    private let router: AnyRouter
    
    private var instructor: LaunchInstructor {
        return LaunchInstructor.configure()
    }
    
    init(coordinatorFactory: ApplicationCoordinatorFactory, router: AnyRouter) {
        self.coordinatorFactory = coordinatorFactory
        self.router = router
    }
    
    override func start() {
        switch instructor {
        case .splash:
            runSplashFlow()
        case .main:
            runMainFlow()
        }
    }
    
    private func runSplashFlow() {
        print("ApplicationCoordinator >> runSplashFlow")
        let coordinator = coordinatorFactory.createSplashCoordinator(router: router)
        coordinator.finishFlowPublisher.sink { [unowned self] _ in
            splashHasBeenShowed = true
            self.start()
            self.removeDependency(coordinator)
        }.store(in: &subscriptions)
        addDependency(coordinator)
        coordinator.start()
    }
    
    private func runMainFlow() {
        print("ApplicationCoordinator >> runMainFlow")
        let coordinator = coordinatorFactory.createMainCoordinator(router: router)
        addDependency(coordinator)
        coordinator.start()
    }
}
