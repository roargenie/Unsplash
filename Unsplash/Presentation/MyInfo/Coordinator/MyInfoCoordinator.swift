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
        navigationController.setNavigationBarHidden(false, animated: false)
    }
    
    func start() {
        let vc = MyInfoViewController(
            viewModel: MyInfoViewModel(
                coordinator: self))
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
