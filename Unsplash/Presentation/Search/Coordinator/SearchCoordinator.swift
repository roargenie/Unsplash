//
//  SearchCoordinator.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import UIKit

final class SearchCoordinator: Coordinator {
    
    weak var delegate: CoordinatorDelegate?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var type: CoordinatorStyleCase = .search
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SearchViewController(
            viewModel: SearchViewModel(
                coordinator: self))
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
    
}
