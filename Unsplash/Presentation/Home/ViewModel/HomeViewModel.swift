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
    var photoCollectionList = BehaviorRelay<[PhotoCollection]>(value: [])
    
    struct Input {
        let refreshButtonTap: Signal<Void>
    }
    
    struct Output {
        let randomPhotoList: Driver<[RandomPhoto]>
        let photoCollectionList: Driver<[PhotoCollection]>
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
        
        
        return Output(
            randomPhotoList: randomPhotoList.asDriver(),
            photoCollectionList: photoCollectionList.asDriver())
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
                dump(value, name: "🟢🟢🟢🟢🟢")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func requestPhotoCollections() {
        print(#function)
        APIManager.shared.requestData([PhotoCollection].self,
                                      router: UnsplashRouter.photoCollection) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let value):
                guard let value = value else { return }
                self.photoCollectionList.accept(value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}











