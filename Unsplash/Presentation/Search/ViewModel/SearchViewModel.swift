//
//  SearchViewModel.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/15.
//

import Foundation
import RxCocoa
import RxSwift

final class SearchViewModel: ViewModelType {
    
    private weak var coordinator: SearchCoordinator?
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    var disposeBag = DisposeBag()
    
    init(coordinator: SearchCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        return Output()
    }
}