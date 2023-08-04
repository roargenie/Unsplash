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

final class MyInfoViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var tableView: UITableView = UITableView().then {
        $0.register(MyInfoTableViewCell.self, forCellReuseIdentifier: MyInfoTableViewCell.identifier)
        $0.register(CustomHeaderView.self, forHeaderFooterViewReuseIdentifier: CustomHeaderView.identifier)
        $0.tableHeaderView = MyInfoTableViewHeader(frame: CGRect(x: 0, y: 0, width: view.frame.size.width , height: 200))
        $0.separatorInset = .zero
//        $0.separatorStyle = .none
        $0.keyboardDismissMode = .onDrag
        $0.backgroundColor = .systemBackground
//        $0.estimatedRowHeight = UITableView.automaticDimension
    }
    
    private let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem().then {
        $0.image = UIImage(systemName: "gearshape")
        $0.style = .plain
    }
    
    //MARK: - Properties
    
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
        navigationItem.backButtonTitle = ""
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    //MARK: - Method
    
    private func bind() {
        let input = MyInfoViewModel.Input(
            rightBarButtonTap: rightBarButtonItem.rx.tap.asSignal())
        let output = viewModel.transform(input: input)
        
        
        
        
    }
    
    deinit {
        print("MyInfoViewController 해제")
    }
}

extension MyInfoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyInfoTableViewCell.identifier, for: indexPath) as? MyInfoTableViewCell else { return UITableViewCell() }
        cell.photoImageView.backgroundColor = .orange
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: CustomHeaderView.identifier) as? CustomHeaderView else { return UIView() }
        
        return view
    }
    
    
    
}
