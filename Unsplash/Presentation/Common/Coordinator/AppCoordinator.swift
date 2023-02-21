//
//  AppCoordinator.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/18.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    weak var delegate: CoordinatorDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorStyleCase = .app
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
//        UserDefaults.standard.set(false, forKey: "isLogedIn")
    }
    
    func start() {
        if UserDefaults.standard.bool(forKey: "isLogedIn") == true {
            showTabBarViewController()
        } else {
            showLoginViewController()
        }
    }
    
    private func showTabBarViewController() {
        let tabBarCoordinator = TabBarCoordinator(self.navigationController)
        tabBarCoordinator.delegate = self
        tabBarCoordinator.start()
        childCoordinators.append(tabBarCoordinator)
    }
    
    private func showLoginViewController() {
        let loginCoordinator = LoginCoordinator(self.navigationController)
        loginCoordinator.delegate = self
        loginCoordinator.start()
        childCoordinators.append(loginCoordinator)
    }
    
}

extension AppCoordinator: CoordinatorDelegate {
    
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0.type != childCoordinator.type }
        self.navigationController.viewControllers.removeAll()
        
        switch childCoordinator.type {
        case .tabBar:
            self.showTabBarViewController()
        case .login:
            self.showLoginViewController()
        default:
            break
        }
    }
    
}
