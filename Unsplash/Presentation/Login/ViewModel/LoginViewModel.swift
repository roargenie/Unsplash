//
//  LoginViewModel.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import Foundation
import RxCocoa
import RxSwift



final class LoginViewModel: ViewModelType {
    
    weak var coordinator: LoginCoordinator?
    private let isValid = BehaviorRelay<Bool>(value: false)
    private let emailValid = BehaviorRelay<Bool>(value: false)
    private let passwordValid = BehaviorRelay<Bool>(value: false)
    
    struct Input {
        let emailTextFiled: Signal<String>
        let passwordTextField: Signal<String>
    }
    
    struct Output {
        let isValid: Driver<Bool>
    }
    
    var disposeBag = DisposeBag()
    
    init(coordinator: LoginCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        input.emailTextFiled
            .map { $0.isValidEmail() }
//            .withUnretained(self)
            .emit { [weak self] value in
                guard let self = self else { return }
                self.emailValid.accept(value)
            }
            .disposed(by: disposeBag)
        
        input.passwordTextField
            .map { $0.count > 4 && $0.count < 16 }
//            .withUnretained(self)
            .emit { [weak self] value in
                guard let self = self else { return }
                self.passwordValid.accept(value)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(emailValid, passwordValid)
            .map { $0 && $1 }
//            .withUnretained(self)
            .subscribe { [weak self] isValid in
                guard let self = self else { return }
                self.isValid.accept(isValid)
            }
            .disposed(by: disposeBag)
        
        return Output(
            isValid: isValid.asDriver(onErrorJustReturn: false))
        
    }
    
    
    
    
    
    
    
    
}
