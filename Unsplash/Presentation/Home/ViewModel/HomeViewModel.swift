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
        let randomPhotoList: BehaviorRelay<[RandomPhoto]>
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
        
        
        return Output(randomPhotoList: randomPhotoList)
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
                print("🟢🟢🟢🟢🟢", value)
            case .failure(let error):
                print(error)
            }
        }
//        let url = "https://api.unsplash.com/photos/random?count=30"
//        let header: HTTPHeaders = ["Authorization": APIKey.authorization]
//        AF.request(url, method: .get, headers: header).responseDecodable(of: RandomPhoto.self) { response in
//            guard let status = response.response?.statusCode else { return }
//            print(response.result, status)
//        }
    }
}











