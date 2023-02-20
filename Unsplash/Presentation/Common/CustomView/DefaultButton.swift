//
//  DefaultButton.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import UIKit

final class DefaultButton: UIButton {
    
    var isValid: Bool = false {
        didSet {
            isValid ? setValidStatus(status: .active) : setValidStatus(status: .inactive)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConfiguration()
    }
    
    convenience init(title text: String) {
        self.init()
        setTitle(text, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("DefaultFillButton: fatal Error Message")
    }
    
    func setConfiguration() {
        layer.masksToBounds = true
        layer.cornerRadius = 8
    }

    func setValidStatus(status: ButtonStatus) {
//        layer.borderWidth = 1
//        tintColor = status.backgroundColor
        backgroundColor = status.backgroundColor
        setTitleColor(status.titleColor, for: .normal)
    }
}
