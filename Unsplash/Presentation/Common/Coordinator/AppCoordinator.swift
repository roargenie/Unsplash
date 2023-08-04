//
//  AppCoordinator.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/18.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func showLoginFlow()
    func showTabBarFlow()
}

final class AppCoordinator: AppCoordinatorProtocol {
    
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorStyleCase = .app
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        if UserDefaults.standard.bool(forKey: "isLogedIn") {
            showTabBarFlow()
        } else {
            showLoginFlow()
        }
    }
    
    func showLoginFlow() {
        let loginCoordinator = LoginCoordinator(self.navigationController)
        loginCoordinator.delegate = self
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }
    
    func showTabBarFlow() {
        let tabBarCoordinator = TabBarCoordinator(self.navigationController)
        tabBarCoordinator.delegate = self
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
    
}

extension AppCoordinator: CoordinatorDelegate {
    
    func didFinish(childCoordinator: Coordinator) {
        print("AppCoordinator didFinish")
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
        navigationController.viewControllers.removeAll()
        
        switch childCoordinator.type {
        case .tabBar:
            showLoginFlow()
        case .login:
            showTabBarFlow()
        default:
            break
        }
    }
    
}
