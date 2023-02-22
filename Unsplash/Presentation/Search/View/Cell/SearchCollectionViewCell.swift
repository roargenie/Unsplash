//
//  SearchCollectionViewCell.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/22.
//

import UIKit


final class SearchCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    static var id: String {
        return NSStringFromClass(Self.self).components(separatedBy: ".").last ?? ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        self.addSubview(imageView)
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func setUpCell(item: SearchResult) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let url = URL(string: item.urls.regular)!
            let data = try? Data(contentsOf: url)
            
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data!)
            }
        }
    }
    
}

