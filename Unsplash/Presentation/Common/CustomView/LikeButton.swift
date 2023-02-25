//
//  LikeButton.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/25.
//

import UIKit

final class LikeButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            isSelected ? setValidStatus(status: .selected) : setValidStatus(status: .deselected)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    convenience init(image: UIImage) {
        self.init()
        setImage(image, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        backgroundColor = .black
        layer.cornerRadius = 25
    }
    
    private func setValidStatus(status: LikeButtonStatus) {
        tintColor = status.tintColor
    }
    
}
