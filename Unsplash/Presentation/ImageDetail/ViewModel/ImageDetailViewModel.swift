//
//  ImageDetailViewModel.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/20.
//

import Foundation
import RxCocoa
import RxSwift

final class ImageDetailViewModel: ViewModelType {
    
    private weak var coordinator: HomeCoordinator?
    var selectedRandomPhoto = BehaviorRelay<[RandomPhoto]>(value: [])
    var selectedCollectionPhoto = BehaviorRelay<[PhotoCollection]>(value: [])
    
    struct Input {
        let likeButtonTap: Signal<Void>
    }
    
    struct Output {
        let selectedRandomPhoto: Driver<[RandomPhoto]>
        let selectedCollectionPhoto: Driver<[PhotoCollection]>
    }
    var disposeBag = DisposeBag()
    
    init(coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        input.likeButtonTap
            .withUnretained(self)
            .emit { vc, _ in
                print("===========탭")
            }
            .disposed(by: disposeBag)
        
        return Output(
            selectedRandomPhoto: selectedRandomPhoto.asDriver(onErrorJustReturn: []),
            selectedCollectionPhoto: selectedCollectionPhoto.asDriver(onErrorJustReturn: []))
    }
    
}
