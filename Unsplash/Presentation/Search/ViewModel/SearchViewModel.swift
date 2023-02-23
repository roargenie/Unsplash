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
    private var searchPhotoList = PublishRelay<SearchPhoto>()
    
    
    struct Input {
        let searchBar: Signal<String>
    }
    
    struct Output {
        let searchPhotoList: Signal<SearchPhoto>
    }
    var disposeBag = DisposeBag()
    
    init(coordinator: SearchCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        input.searchBar
            .debounce(.seconds(1))
            .withUnretained(self)
            .emit { vc, value in
                vc.requestSearchPhoto(query: value)
            }
            .disposed(by: disposeBag)
        
        
        
        
        return Output(
            searchPhotoList: searchPhotoList.asSignal())
    }
    
    func requestSearchPhoto(query: String) {
        APIManager.shared.requestData(SearchPhoto.self,
                                      router: UnsplashRouter.searchPhoto(query)) { [weak self] response in
            guard let self = self else { return }
            print(#function)
            switch response {
            case .success(let value):
                guard let value = value else { return }
                self.searchPhotoList.accept(value)
                print("=======🔵======", value)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
     
}
