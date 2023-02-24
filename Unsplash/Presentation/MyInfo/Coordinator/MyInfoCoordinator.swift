//
//  MyInfoCoordinator.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import UIKit

final class MyInfoCoordinator: Coordinator {
    
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .myInfo
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = MyInfoViewController(
            viewModel: MyInfoViewModel(
                coordinator: self))
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showLoginViewController() {
        let loginCoordinator = LoginCoordinator(navigationController)
        loginCoordinator.delegate = self
        self.childCoordinators.append(loginCoordinator)
        UserDefaults.standard.set(false, forKey: "isLogedIn")
        loginCoordinator.start()
//        finish()
//        didFinish(childCoordinator: self)
    }
    
    func showSettingViewController() {
        let settingViewController = SettingViewController(
            viewModel: SettingViewModel(
                coordinator: self))
        navigationController.pushViewController(settingViewController, animated: true)
    }
    
    func finish() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    
}

extension MyInfoCoordinator: CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
        if childCoordinator.type == .myInfo {
            self.navigationController.viewControllers.removeAll()
            self.delegate?.didFinish(childCoordinator: self)
        }
    }
}
