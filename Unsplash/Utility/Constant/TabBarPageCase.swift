//
//  TabBarPageCase.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import Foundation

enum TabBarPageCase: String, CaseIterable {
    case home, search, login
    
    init?(index: Int) {
        switch index {
        case 0: self = .home
        case 1: self = .search
        case 2: self = .login
        default: return nil
        }
    }
    
    var pageOrderNumber: Int {
        switch self {
        case .home: return 0
        case .search: return 1
        case .login: return 2
        }
    }
    
    var pageTitle: String {
        switch self {
        case .home: return ""
        case .search: return ""
        case .login: return ""
        }
    }
    
    var tabIconName: String {
        switch self {
        case .home: return "house"
        case .search: return "magnifyingglass"
        case .login: return "person.crop.circle"
        }
    }
    
}
