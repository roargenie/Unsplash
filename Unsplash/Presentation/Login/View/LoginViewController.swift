//
//  LoginViewController.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

final class LoginViewController: UIViewController {
    
    //MARK: - UI
    
    private var emailTextField = DefaultTextField(placeHolder: "Email")
    private var passwordTextField = DefaultTextField(placeHolder: "Password")
    private var loginButton = DefaultButton(title: "Log In")
    
    //MARK: - Properties
    
    private lazy var input = LoginViewModel.Input(
        emailTextFiled: emailTextField.rx.text.orEmpty.asSignal(onErrorJustReturn: ""),
        passwordTextField: passwordTextField.rx.text.orEmpty.asSignal(onErrorJustReturn: ""))
    private lazy var output = viewModel.transform(input: input)
    private let viewModel: LoginViewModel
    private var disposeBag = DisposeBag()
    
    //MARK: - Init

    init(viewModel: LoginViewModel) {
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
        navigationItem.title = "Login"
        navigationController?.navigationBar.prefersLargeTitles = true
        [emailTextField, passwordTextField, loginButton].forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(44)
        }
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
    }
    
    
    
    //MARK: - Method

    private func bind() {
        
        output.isValid
            .drive(loginButton.rx.isValid)
            .disposed(by: disposeBag)
        
            
            
            
        
        
    }
    
    
    
}

    //MARK: - Extension

extension LoginViewController {
    
    
    
}
