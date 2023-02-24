//
//  LoginCoordinator.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import UIKit

final class LoginCoordinator: Coordinator {
    
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .login
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(false, animated: false)
    }
    
    func start() {
        let vc = LoginViewController(
            viewModel: LoginViewModel(
                coordinator: self))
        vc.hidesBottomBarWhenPushed = true
        changeAnimation()
        navigationController.viewControllers = [vc]
//        navigationController.pushViewController(vc, animated: true)
    }
    
    func showSignupViewController() {
        let vc = SignUpViewController(
            viewModel: SignUpViewModel(
                coordinator: self))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showTabBarViewController() {
        let tabBarCoordinator = TabBarCoordinator(self.navigationController)
//        tabBarCoordinator.delegate = self
        self.childCoordinators.append(tabBarCoordinator)
        UserDefaults.standard.set(true, forKey: "isLogedIn")
        tabBarCoordinator.start()
    }
    
    func popToLoginViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func finish() {
        delegate?.didFinish(childCoordinator: self)
    }
}

//extension LoginCoordinator: CoordinatorDelegate {
//    func didFinish(childCoordinator: Coordinator) {
//        self.childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
//        if childCoordinator.type == .login {
//            self.navigationController.viewControllers.removeAll()
//            self.delegate?.didFinish(childCoordinator: self)
//        }
//    }
//}
