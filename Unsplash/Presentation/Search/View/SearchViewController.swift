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

final class SearchViewController: UIViewController {
    
    //MARK: - UI
    
    private var searchBar = UISearchBar()
    private lazy var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: .searchCollectionLayout()).then {
            $0.keyboardDismissMode = .onDrag
    }
    
    //MARK: - Properties
    
    private lazy var input = SearchViewModel.Input(
        searchBar: searchBar.rx.text.orEmpty.asSignal(onErrorJustReturn: ""))
    private lazy var output = viewModel.transform(input: input)
    private let viewModel: SearchViewModel
    private var disposeBag = DisposeBag()
    
    private var dataSource: UICollectionViewDiffableDataSource<Int, SearchResult>!
    
    //MARK: - Init

    init(viewModel: SearchViewModel) {
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
        configureDataSource()
    }
    
    //MARK: - SetUI
    
    private func configureUI() {
        navigationItem.title = "Search"
        view.backgroundColor = .black
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    private func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    //MARK: - Method

    private func bind() {
        
        output.searchPhotoList
            .withUnretained(self)
            .emit { vc, value in
                var snapshot = NSDiffableDataSourceSnapshot<Int, SearchResult>()
                snapshot.appendSections([0])
                snapshot.appendItems(value.results)
                vc.dataSource.apply(snapshot, animatingDifferences: true)
            }
            .disposed(by: disposeBag)
        
        
    }
    
}

    //MARK: - Extension

extension SearchViewController {
    
    private func configureDataSource() {
        let cellregistration = UICollectionView.CellRegistration<SearchCollectionViewCell, SearchResult> { cell, indexPath, itemIdentifier in
            cell.setUpCell(item: itemIdentifier)
        }
        
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(
                using: cellregistration,
                for: indexPath,
                item: itemIdentifier)
            return cell
        })
    }
}
