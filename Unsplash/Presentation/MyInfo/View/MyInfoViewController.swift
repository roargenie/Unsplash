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
    
    private var profileImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 26
        $0.backgroundColor = .orange
    }
    private var nickNameLabel: UILabel = UILabel()
    private var tableView: UITableView = UITableView()
    private var rightBarButtonItem: UIBarButtonItem = UIBarButtonItem()
    
    
    //MARK: - Properties

    private lazy var input = MyInfoViewModel.Input()
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
        self.view.backgroundColor = .blue
    }
    
    
    
    
    //MARK: - SetUI

    
    
    
    //MARK: - Method

}
