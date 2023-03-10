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
        let rightBarButtonTap: Signal<Void>
    }
    
    struct Output {
        
    }
    var disposeBag = DisposeBag()
    
    init(coordinator: MyInfoCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        input.rightBarButtonTap
            .withUnretained(self)
            .emit { vc, _ in
                vc.coordinator?.showSettingViewController()
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
}
