//
//  MyInfoViewController.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class MyInfoViewController: UIViewController {
    
    //MARK: - UI
    
//    private var profileImageView: UIImageView = UIImageView().then {
//        $0.contentMode = .scaleAspectFit
//        $0.layer.cornerRadius = 26
//        $0.backgroundColor = .orange
//    }
//    private var nickNameLabel: UILabel = UILabel()
//    private var tableView: UITableView = UITableView()
    private let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "ellipsis")
        $0.style = .plain
    }
    
    private var testButtond = DefaultButton(title: "TestButton")
    
    
    //MARK: - Properties

    private lazy var input = MyInfoViewModel.Input(
        testButtonTap: testButtond.rx.tap.asSignal(),
        rightBarButtonTap: rightBarButtonItem.rx.tap.asSignal())
    private lazy var output = viewModel.transform(input: input)
    private let viewModel: MyInfoViewModel
    private var disposeBag = DisposeBag()
    
    //MARK: - Init

    init(viewModel: MyInfoViewModel) {
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
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.title = "My Page"
        view.addSubview(testButtond)
        
    }
    
    private func setConstraints() {
        testButtond.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    
    //MARK: - Method
    
    private func bind() {
        
//        testButtond.rx.tap
//            .withUnretained(self)
//            .bind { vc, _ in
//                print("===============✅")
//
//            }
//            .disposed(by: disposeBag)
    }
    
    
    
    
}
