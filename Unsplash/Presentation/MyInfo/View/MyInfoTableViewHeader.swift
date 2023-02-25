//
//  MyInfoTableViewHeader.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/24.
//

import UIKit

final class MyInfoTableViewHeader: UIView {
    
    let profileImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .orange
        $0.layer.cornerRadius = 40
    }
    
    let nicknameLabel: UILabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 24, weight: .heavy)
        $0.text = "rOar"
        $0.backgroundColor = .brown
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .gray
        addSubview(profileImageView)
        addSubview(nicknameLabel)
    }
    
    private func setConstraints() {
        
        profileImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
//            make.bottom.equalToSuperview().inset(100)
            make.width.height.equalTo(80)
        }
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
            make.centerX.equalTo(profileImageView.snp.centerX)
        }
        
    }
    
}
