//
//  ViewModelType.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import Foundation
import RxSwift

protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    var disposeBag: DisposeBag { get set }

    func transform(input: Input) -> Output
}
