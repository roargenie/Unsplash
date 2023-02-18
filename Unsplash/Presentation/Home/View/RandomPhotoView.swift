//
//  RandomPhotoView.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class RandomPhotoView: UIView {
    
    //MARK: - UI

    var collectionView: UICollectionView!
    var refreshButton: UIButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        $0.layer.cornerRadius = 54 / 2
        $0.tintColor = .white
        $0.backgroundColor = .black
    }
    
    //MARK: - Properties
    
//    private lazy var input = HomeViewModel.Input(refreshButtonTap: refreshButton.rx.tap.asSignal())
//    private lazy var output = viewModel.transform(input: input)
//    private let viewModel = HomeViewModel(coordinator: <#HomeCoordinator?#>)
//    private let diposeBag = DisposeBag()
    var data: [RandomPhoto] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
//    var data: [MockData] = []
    
//    init(viewModel: HomeViewModel, frame: CGRect) {
//        self.viewModel = viewModel
////        super.init()
//        super.init(frame: frame)
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupData()
        configureUI()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        let collectionViewLayout = CustomLayout()
        collectionViewLayout.delegate = self
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
//        collectionView.layer.borderWidth = 1
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.id)
        self.addSubview(refreshButton)
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        refreshButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().inset(8)
            make.width.height.equalTo(54)
        }
    }
    
    private func setupData() {
//        data = MockData.getMock()
    }
    
    private func bind() {
        
    }
    
//    private func imageDownload(item: RandomPhoto) {
//        DispatchQueue.global().async {
//            let url = URL(string: item.urls.regular)!
//            let data = try? Data(contentsOf: url)
//        }
//    }
    
}

extension RandomPhotoView: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        let data = data
//        data[indexPath.item].contentHeightSize
        return CGFloat(data[indexPath.item].height / 20)
    }
}

extension RandomPhotoView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.id, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
//        cell.myModel = data[indexPath.item]
        let data = data
        DispatchQueue.global().async {
            let url = URL(string: data[indexPath.item].urls.regular)!
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let image = data {
                    cell.imageView.image = UIImage(data: image)
                }
            }
        }
        return cell
    }
    
}
