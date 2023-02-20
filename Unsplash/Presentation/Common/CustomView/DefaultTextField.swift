//
//  DefaultTextField.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/21.
//

import UIKit.UITextField

final class DefaultTextField: UITextField, UITextFieldDelegate {
    
    private let border = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setConfiguration()
    }
    
    convenience init(placeHolder text: String) {
        self.init()
        placeholder = text
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        border.frame = CGRect(x: 0, y: frame.size.height - 1, width: frame.width, height: 1)
        setBorderLine()
    }
    
    required init?(coder: NSCoder) {
        fatalError("AuthTextField: fatal Error")
    }
    
    private func setConfiguration() {
        delegate = self
        borderStyle = .none
        addPadding()
    }
    
    private func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        leftView = paddingView
        leftViewMode = ViewMode.always
    }
    
    func setBorderLine() {
        border.frame = CGRect(x: 0, y: frame.size.height - 1, width: frame.width, height: 1)
        border.backgroundColor = UIColor.lightGray.cgColor
        layer.addSublayer(border)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        border.backgroundColor = UIColor.white.cgColor
        textField.setPlaceholder(color: .white)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        border.backgroundColor = UIColor.lightGray.cgColor
        textField.setPlaceholder(color: .lightGray)
    }
}
