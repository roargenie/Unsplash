//
//  SignUpViewModel.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import Foundation
import RxCocoa
import RxSwift

final class SignUpViewModel: ViewModelType {
    
    private weak var coordinator: LoginCoordinator?
    
    private let emailValid = BehaviorRelay<Bool>(value: false)
    private let passwordValid = BehaviorRelay<Bool>(value: false)
    private let passwordCheckValid = BehaviorRelay<Bool>(value: false)
    private let signUpValid = BehaviorRelay<Bool>(value: false)
    
    struct Input {
        let nicknameTextField: Signal<String>
        let emailTextField: Signal<String>
        let passwordTextField: Signal<String>
        let passwordCheckTextField: Signal<String>
//        let emailValidLabel: AnyObserver<String?>
//        let passwordValidLabel: Observable<String?>
    }
    
    struct Output {
        let emailValid: Driver<Bool>
        let passwordCheckValid: Driver<Bool>
        let signUpValid: Driver<Bool>
    }
    var disposeBag = DisposeBag()
    
    init(coordinator: LoginCoordinator?) {
        self.coordinator = coordinator
    }
    
    func transform(input: Input) -> Output {
        
        input.emailTextField
            .map { $0.isValidEmail() }
            .withUnretained(self)
            .emit { vc, value in
                vc.emailValid.accept(value)
            }
            .disposed(by: disposeBag)
        
        input.passwordTextField
            .map { $0.count > 8 }
            .withUnretained(self)
            .emit { vc, value in
                vc.passwordValid.accept(value)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(input.passwordTextField.asObservable(), input.passwordCheckTextField.asObservable())
            .map { $0 == $1 && !$0.isEmpty && !$1.isEmpty }
            .withUnretained(self)
            .bind { vc, value in
                vc.passwordCheckValid.accept(value)
            }
            .disposed(by: disposeBag)
        
        Observable.combineLatest(emailValid, passwordCheckValid)
            .map { $0 && $1 }
            .withUnretained(self)
            .bind { vc, value in
                vc.signUpValid.accept(value)
            }
            .disposed(by: disposeBag)
        
        
        return Output(
            emailValid: emailValid.asDriver(onErrorJustReturn: false),
            passwordCheckValid: passwordCheckValid.asDriver(onErrorJustReturn: false),
            signUpValid: signUpValid.asDriver(onErrorJustReturn: false))
    }
}

extension SignUpViewModel {
    
    private func passwordCheck(with text: String) {
        
    }
}
