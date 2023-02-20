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

    //MARK: - Extension

extension UICollectionViewLayout {
    static func photoCollectionFlowLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(UIScreen.main.bounds.size.height / 3))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 4,
            leading: 0,
            bottom: 0,
            trailing: 0)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
        
    }
}
