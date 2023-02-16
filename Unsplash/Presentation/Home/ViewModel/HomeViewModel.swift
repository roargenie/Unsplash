//
//  HomeViewModel.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import Foundation
import RxCocoa
import RxSwift

final class HomeViewModel: ViewModelType {
    
    private weak var coordinator: HomeCoordinator?
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    var disposeBag = DisposeBag()
    
    init(coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}











