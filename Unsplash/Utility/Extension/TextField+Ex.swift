//
//  TextField+Ex.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import UIKit

extension UITextField {
    func setPlaceholder(color: UIColor) {
        guard let string = self.placeholder else {
            return
        }
        attributedPlaceholder = NSAttributedString(
            string: string,
            attributes: [.foregroundColor: color])
    }
}
