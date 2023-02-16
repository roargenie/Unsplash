//
//  CoordinatorDelegate.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import Foundation

protocol CoordinatorDelegate: AnyObject {
    func didFinish(childCoordinator: Coordinator)
}
