//
//  TabBarPageCase.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import Foundation

enum TabBarPageCase: String, CaseIterable {
    case home, search
    
    init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .search
        default: return nil
        }
    }
    
    var pageOrderNumber: Int {
        switch self {
        case .home: return 0
        case .search: return 1
        }
    }
    
    var pageTitle: String {
        switch self {
        case .home: return "Home"
        case .search: return "Search"
        }
    }
    
    var tabIconName: String {
        switch self {
        case .home: return "house"
        case .search: return "magnifyingglass"
        }
    }
    
}
