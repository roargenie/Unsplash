//
//  SettingViewModel.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/24.
//

import Foundation
import RxCocoa
import RxSwift

final class SettingViewModel: ViewModelType {
    
    private weak var coordinator: MyInfoCoordinator?
    
    struct Input {
        let logOutButtonTap: Signal<Void>
    }
    
    struct Output {
        
    }
    var disposeBag = DisposeBag()
    
    init(coordinator: MyInfoCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        input.logOutButtonTap
            .withUnretained(self)
            .emit { vc, _ in
                vc.coordinator?.showLoginViewController()
            }
            .disposed(by: disposeBag)
        
        
        
        return Output()
    }
}
