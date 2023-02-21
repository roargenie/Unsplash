//
//  SearchViewController.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewModel
    private var disposeBag = DisposeBag()
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
    }
    
}

