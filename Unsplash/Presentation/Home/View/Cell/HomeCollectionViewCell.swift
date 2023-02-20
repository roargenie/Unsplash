//
//  HomeCollectionViewCell.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/17.
//

import UIKit
import SnapKit

final class HomeCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
    }
    
    static var id: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setUpCell(item: RandomPhotoCollectionType) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let url = URL(string: item.urls.regular)!
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let image = data {
                    self.imageView.image = UIImage(data: image)
                }
            }
        }
    }
    
}
