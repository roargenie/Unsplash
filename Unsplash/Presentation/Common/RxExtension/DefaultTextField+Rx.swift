//
//  DefaultTextField+Rx.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import RxSwift

extension Reactive where Base: DefaultTextField {

    var limitPhoneNumberText: Observable<String> {
        return text
            .orEmpty
            .filter { !$0.contains("-") }
            .map { text in
                return text.limitString(limitCount: 11)
            }
    }
}
