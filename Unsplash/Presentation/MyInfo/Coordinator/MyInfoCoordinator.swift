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
    
    func showLoginFlow() {
        UserDefaults.standard.set(false, forKey: "isLogedIn")
        let coordinator = LoginCoordinator(self.navigationController)
        coordinator.delegate = self
        self.childCoordinators.append(coordinator)
        coordinator.start()
        self.finish()
        print(childCoordinators, #function)
    }
    
    func showSettingViewController() {
        let settingViewController = SettingViewController(
            viewModel: SettingViewModel(
                coordinator: self))
        navigationController.pushViewController(settingViewController, animated: true)
    }
    
    deinit {
        print("MyInfo Coordinator 해제")
    }
    
}

extension MyInfoCoordinator: CoordinatorDelegate {
    func didFinish(childCoordinator: Coordinator) {
        print("MyInfoCoordinator", childCoordinators, childCoordinator)
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
        navigationController.viewControllers.removeAll()
    }
}
