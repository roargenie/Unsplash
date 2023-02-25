//
//  LikeButtonStatus.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/25.
//

import UIKit

enum LikeButtonStatus {
    
    case selected
    case deselected
    
    var tintColor: UIColor {
        switch self {
        case .selected:
            return .red
        case .deselected:
            return .white
        }
    }
    
}
