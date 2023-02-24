//
//  SettingViewController.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class SettingViewController: UIViewController {
    
    //MARK: - UI
    
    private let logOutButton = DefaultButton(title: "Log Out")
    
    
    
    //MARK: - Properties
    
    private let viewModel: SettingViewModel
    private var disposeBag = DisposeBag()
    
    //MARK: - Init
    
    
    init(viewModel: SettingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        configureUI()
        setConstraints()
        bind()
    }
    
    //MARK: - SetUI
    
    private func configureUI() {
        view.addSubview(logOutButton)
    }
    
    private func setConstraints() {
        logOutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(80)
        }
    }
    
    
    //MARK: - Method
    
    private func bind() {
        let input = SettingViewModel.Input(
            logOutButtonTap: logOutButton.rx.tap.asSignal())
        let output = viewModel.transform(input: input)
        
    }
    
    
    
    
    
}

