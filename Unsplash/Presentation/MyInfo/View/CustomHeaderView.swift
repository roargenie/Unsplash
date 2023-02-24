//
//  CustomHeaderView.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/24.
//

import UIKit

final class CustomHeaderView: UITableViewHeaderFooterView {
    
    static let identifier = "CustomHeaderView"
    
    let titleLabel: UILabel = UILabel().then {
        $0.text = "Likes"
        $0.font = .systemFont(ofSize: 25, weight: .heavy)
        $0.textColor = .white
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureUI()
        setConstraints()
        backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(titleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
}
