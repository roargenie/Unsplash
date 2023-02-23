//
//  MyInfoViewModel.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import Foundation
import RxCocoa
import RxSwift

final class MyInfoViewModel: ViewModelType {
    
    private weak var coordinator: MyInfoCoordinator?
    
    struct Input {
        let testButtonTap: Signal<Void>
        let rightBarButtonTap: Signal<Void>
    }
    
    struct Output {
        
    }
    var disposeBag = DisposeBag()
    
    init(coordinator: MyInfoCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        input.testButtonTap
            .withUnretained(self)
            .emit { vc, _ in
                print("clicked")
//                vc.coordinator?.showLoginViewController()
            }
            .disposed(by: disposeBag)
        
        input.rightBarButtonTap
            .withUnretained(self)
            .emit { vc, _ in
                print("==============")
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
