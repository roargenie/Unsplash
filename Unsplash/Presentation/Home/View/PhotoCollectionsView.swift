//
//  PhotoCollectionsView.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import UIKit
import SnapKit

final class PhotoCollectionsView: UIView {
    
    //MARK: - UI

    lazy var collectionView: UICollectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: UICollectionViewLayout.photoCollectionFlowLayout()).then {
        $0.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.id)
        $0.backgroundColor = .black
    }
    
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
        addSubview(collectionView)
    }
    
    private func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
