//
//  InputView.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/06.
//

import UIKit

class InputCommentView: UIView, CustomViewProtocol {

    let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "댓글을 입력하세요"
        textField.addLeftPadding()
        textField.layer.cornerRadius = 20
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGray6
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(textField)
        self.addSubview(registerButton)
    }
    
    func makeConstraints() {
        registerButton.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(5)
            $0.width.equalTo(registerButton.snp.height).multipliedBy(1.0)
        }
        registerButton.layer.cornerRadius = 15
        
        textField.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview().inset(5)
            $0.trailing.equalTo(registerButton.snp.leading).inset(-5)
            $0.height.equalTo(40)
        }
    }
}
