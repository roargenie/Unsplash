//
//  HomeCoordinator.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import UIKit

final class HomeCoordinator: Coordinator {
    
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .home
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    func start() {
        let vc = HomeViewController(
            viewModel: HomeViewModel(
                coordinator: self))
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
}
