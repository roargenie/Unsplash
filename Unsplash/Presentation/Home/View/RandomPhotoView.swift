//
//  RandomPhotoView.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import UIKit
import SnapKit

final class RandomPhotoView: UIView {
    
//    var collectionView = UICollectionView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
//        addSubview(collectionView)
        self.backgroundColor = .yellow
    }
    
    private func setConstraints() {
//        collectionView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
    
}
