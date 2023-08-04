//
//  LoginCoordinator.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func showLoginViewController()
    func showSignupViewController()
}

final class LoginCoordinator: LoginCoordinatorProtocol {
    
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .login
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(false, animated: false)
    }
    
    func start() {
        showLoginViewController()
    }
    
    func showLoginViewController() {
        let vc = LoginViewController(
            viewModel: LoginViewModel(
                coordinator: self))
        vc.hidesBottomBarWhenPushed = true
        changeAnimation()
        navigationController.viewControllers = [vc]
    }
    
    func showSignupViewController() {
        let vc = SignUpViewController(
            viewModel: SignUpViewModel(
                coordinator: self))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showTabBarFlow() {
        UserDefaults.standard.set(true, forKey: "isLogedIn")
        let tabBarCoordinator = TabBarCoordinator(self.navigationController)
        tabBarCoordinator.delegate = self
        childCoordinators.append(tabBarCoordinator)
        tabBarCoordinator.start()
        self.finish()
    }
    
    func popToLoginViewController() {
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        print("Login Coordinator deinit")
    }
    
}

extension LoginCoordinator: CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        print("==========LoginCoordinator didFinish")
        self.childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
        print(childCoordinators, childCoordinator)
//        self.childCoordinators.removeAll()
//        self.delegate?.didFinish(childCoordinator: self)
    }
}
