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
    
    var data: [RandomPhoto] = []
    
    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        configureUI()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Method

    private func configureUI() {
        let collectionViewLayout = CustomLayout()
        collectionViewLayout.delegate = self
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .black
        collectionView.contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.addSubview(collectionView)
        
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
    
}

    //MARK: - Extension

extension RandomPhotoView: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        let height = CGFloat(data[indexPath.item].height)
        return height > 3500 ? height / 25 : height / 15
    }
}

