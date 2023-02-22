//
//  SignUpViewController.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Toast

final class SignUpViewController: UIViewController {
    
    //MARK: - UI
    
    private var nickNameTextField = DefaultTextField(placeHolder: "Username")
    private var emailTextField = DefaultTextField(placeHolder: "Email")
    private var passwordTextField = DefaultTextField(placeHolder: "Password")
    private var passwordCheckTextField = DefaultTextField(placeHolder: "Password")
    
    private var emailValidLabel = DefaultLabel()
    private var passwordValidLabel = DefaultLabel()
    
    private var signUpButton = DefaultButton(title: "Sign Up")
    
    //MARK: - Properties
    
    private lazy var input = SignUpViewModel.Input(
        nicknameTextField: nickNameTextField.rx.text.orEmpty.asSignal(onErrorJustReturn: ""),
        emailTextField: emailTextField.rx.text.orEmpty.asSignal(onErrorJustReturn: ""),
        passwordTextField: passwordTextField.rx.text.orEmpty.asSignal(onErrorJustReturn: ""),
        passwordCheckTextField: passwordCheckTextField.rx.text.orEmpty.asSignal(onErrorJustReturn: ""),
        signUpButtonTapped: signUpButton.rx.tap.asSignal())
    private lazy var output = viewModel.transform(input: input)
    private let viewModel: SignUpViewModel
    private var disposeBag = DisposeBag()
    
    //MARK: - Init

    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        bind()
    }
    
    
    //MARK: - SetUI

    private func configureUI() {
        view.backgroundColor = .black
        [nickNameTextField, emailTextField, passwordTextField,
         passwordCheckTextField, emailValidLabel, passwordValidLabel, signUpButton]
            .forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        emailValidLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.centerX.equalTo(emailTextField.snp.centerX)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailValidLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        passwordCheckTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        passwordValidLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordCheckTextField.snp.bottom).offset(8)
            make.centerX.equalTo(passwordCheckTextField.snp.centerX)
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidLabel.snp.bottom).offset(36)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
    }
    
    
    //MARK: - Method
    
    private func bind() {
        
        output.emailValid
            .drive(emailValidLabel.rx.isValid)
            .disposed(by: disposeBag)
        
        output.passwordCheckValid
            .drive(passwordValidLabel.rx.isValid)
            .disposed(by: disposeBag)
        
        output.signUpValid
            .drive(signUpButton.rx.isValid)
            .disposed(by: disposeBag)
        
        output.makeToast
            .withUnretained(self)
            .emit { vc, value in
                vc.view.makeToast(value, duration: 0.5, position: .top)
            }
            .disposed(by: disposeBag)
        
    }
    
}

    //MARK: - Extension

extension SignUpViewController {
    
}
