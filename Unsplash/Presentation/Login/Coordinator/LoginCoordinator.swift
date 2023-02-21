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
    }
    
    func start() {
        let vc = LoginViewController(
            viewModel: LoginViewModel(
                coordinator: self))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showSignupViewController() {
        let vc = SignUpViewController(
            viewModel: SignUpViewModel(
                coordinator: self))
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
