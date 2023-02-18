//
//  HomeViewModel.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import Foundation
import Alamofire
import RxCocoa
import RxSwift

final class HomeViewModel: ViewModelType {
    
    private weak var coordinator: HomeCoordinator?
    var randomPhotoList = BehaviorRelay<[RandomPhoto]>(value: [])
    
    struct Input {
        let refreshButtonTap: Signal<Void>
    }
    
    struct Output {
        let randomPhotoList: Driver<[RandomPhoto]>
    }
    
    var disposeBag = DisposeBag()
    
    init(coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        input.refreshButtonTap
            .withUnretained(self)
            .emit { _ in
                self.requestRandomPhoto()
            }
            .disposed(by: disposeBag)
        
        
        return Output(randomPhotoList: randomPhotoList.asDriver())
    }
    
    func requestRandomPhoto() {
        print(#function)
        APIManager.shared.requestData([RandomPhoto].self,
                                      router: UnsplashRouter.randomPhoto) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let value):
                guard let value = value else { return }
                self.randomPhotoList.accept(value)
//                print("🟢🟢🟢🟢🟢", value)
                dump(value, name: "🟢🟢🟢🟢🟢")
            case .failure(let error):
                print(error)
            }
        }
    }
}











