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
        let randomPhotoItemSelected: Signal<RandomPhoto>
        let photoCollectionItemSelected: Signal<PhotoCollection>
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
            .throttle(.seconds(1), latest: false)
            .emit { vc, _ in
                vc.requestRandomPhoto()
            }
            .disposed(by: disposeBag)
        
        input.randomPhotoItemSelected
            .withUnretained(self)
            .emit { vc, item in
                vc.coordinator?.showImageDetailViewController(item: item)
            }
            .disposed(by: disposeBag)
        
        input.photoCollectionItemSelected
            .withUnretained(self)
            .emit { vc, item in
                vc.coordinator?.showImageDetailViewController(item: item)
            }
            .disposed(by: disposeBag)
        
        
        
        return Output(
            randomPhotoList: randomPhotoList.asDriver(),
            photoCollectionList: photoCollectionList.asDriver())
    }
    
    func requestRandomPhoto() {
        APIManager.shared.requestData([RandomPhoto].self,
                                      router: UnsplashRouter.randomPhoto) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let value):
                guard let value = value else { return }
                self.randomPhotoList.accept(value)
//                dump(value, name: "🟢🟢🟢🟢🟢")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func requestPhotoCollections() {
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











