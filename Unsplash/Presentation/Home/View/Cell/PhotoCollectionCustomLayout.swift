//
//  PhotoCollectionCustomLayout.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/20.
//

import UIKit

final class PhotoCollectionCustomLayout: UICollectionViewLayout {
    
    weak var delegate: CustomLayoutDelegate?
    
    fileprivate var cellPadding: CGFloat = 0.0
    fileprivate var cache: [UICollectionViewLayoutAttributes] = []
    fileprivate var contentHeight: CGFloat = 0.0
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0.0 }
        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        cache.removeAll()
        
        let columnWidth: CGFloat = contentWidth
        var xOffset: [CGFloat] = []
        
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { rect.intersects($0.frame) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
}

