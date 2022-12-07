//
//  BaseCoordinator.swift
//  Raqamyat-Ecommerce
//
//  Created by Yousef Mohamed on 07/12/2022.
//

import Foundation
import Combine

class BaseCoordinator: NSObject, AnyCoordinator {
    
    var subscriptions = Set<AnyCancellable>()
    var childCoordinators: [AnyCoordinator] = []
    
    func start() {}
    
    // add only unique object
    func addDependency(_ coordinator: AnyCoordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: AnyCoordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator
        else { return }
        
        // Clear child-coordinators recursively
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter({ $0 !== coordinator })
                .forEach({ coordinator.removeDependency($0) })
        }
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
    
    deinit {
        let content = self.description + " Has been deinitialized "
        let dashed = String(repeating: "#", count: content.count)
        print(dashed)
        print(content)
        print(dashed)
    }
}
