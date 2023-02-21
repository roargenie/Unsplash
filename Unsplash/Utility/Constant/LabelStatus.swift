//
//  LabelStatus.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import UIKit

enum LabelStatus {
    
    case valid
    case notValid
    
    var titleColor: UIColor {
        switch self {
        case .valid:
            return .green
        case .notValid:
            return .red
        }
    }
    
    var titleText: String {
        switch self {
        case .valid:
            return "Valid Form."
        case .notValid:
            return "Not Valid Form"
        }
    }
    
    
}
