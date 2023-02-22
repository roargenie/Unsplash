//
//  DefaultLabel.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import UIKit

final class DefaultLabel: UILabel {
    
    var isValid: Bool = false {
        didSet {
            isValid ? setValidStatus(status: .valid) : setValidStatus(status: .notValid)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    convenience init(title text: String) {
        self.init()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValidStatus(status: LabelStatus) {
        textColor = status.titleColor
        text = status.titleText
    }
    
}
