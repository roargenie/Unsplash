//
//  ButtonStatus.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import UIKit

enum ButtonStatus {
    
    case active
    case inactive
    case normal
    
    var backgroundColor: UIColor {
        switch self {
        case .active:
            return .red
        case .inactive:
            return .gray
        case .normal:
            return .white
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .active:
            return .white
        case .inactive:
            return .white
        case .normal:
            return .black
        }
    }
    
    
}
