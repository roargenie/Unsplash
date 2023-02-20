//
//  DefaultButton+Rx.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import RxSwift
import RxCocoa

extension Reactive where Base: DefaultButton {
    
    func isValid() -> Binder<Bool> {
        return Binder(base) { button, isValid in
            if isValid {
                button.isValid = true
            } else {
                button.isValid = false
            }
        }
    }
}
