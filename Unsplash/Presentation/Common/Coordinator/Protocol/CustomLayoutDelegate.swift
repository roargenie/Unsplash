//
//  CustomLayoutDelegate.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import UIKit

protocol CustomLayoutDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat
}
