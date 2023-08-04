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
    private let makeToast = PublishRelay<String>()
    
    struct Input {
        let emailTextFiled: Signal<String>
        let passwordTextField: Signal<String>
        let signUpButtonTapped: Signal<Void>
        let loginButtonTapped: Signal<Void>
    }
    
    struct Output {
        let isValid: Driver<Bool>
        let makeToast: Signal<String>
    }
    
    var disposeBag = DisposeBag()
    
    init(coordinator: LoginCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        input.emailTextFiled
            .map { $0.isValidEmail() }
            .withUnretained(self)
            .emit { vm, value in
                vm.emailValid.accept(value)
            }
            .disposed(by: disposeBag)
        
        input.passwordTextField
            .map { $0.count > 8 }
            .withUnretained(self)
            .emit { vm, value in
                vm.passwordValid.accept(value)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(emailValid, passwordValid)
            .map { $0 && $1 }
            .withUnretained(self)
            .bind { vm, isValid in
                vm.isValid.accept(isValid)
            }
            .disposed(by: disposeBag)
        
        input.signUpButtonTapped
            .withUnretained(self)
            .emit { vm, _ in
                vm.coordinator?.showSignupViewController()
            }
            .disposed(by: disposeBag)
        
        input.loginButtonTapped
            .withLatestFrom(isValid.asDriver())
            .withUnretained(self)
            .emit { vm, value in
                value ? vm.coordinator?.showTabBarFlow() : vm.makeToast.accept("Failed Login")
            }
            .disposed(by: disposeBag)
        
        return Output(
            isValid: isValid.asDriver(onErrorJustReturn: false),
            makeToast: makeToast.asSignal(onErrorJustReturn: ""))
        
    }
    
     
}
