//
//  MyInfoTableViewCell.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/24.
//

import UIKit

final class MyInfoTableViewCell: UITableViewCell {
    
    static let identifier = "MyInfoTableViewCell"
    
    let photoImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(photoImageView)
    }
    
    private func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    
}
