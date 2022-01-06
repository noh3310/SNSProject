//
//  SignInView.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/03.
//

import UIKit

class SignInView: UIView, CustomViewProtocol {
    
    let identifierTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "이메일을 입력하세요"
        return textfield
    }()
    
    let passwordTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "비밀번호를 입력하세요"
        return textfield
    }()
    
    
    let loginButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("로그인", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        self.addSubview(identifierTextField)
        self.addSubview(passwordTextField)
        self.addSubview(loginButton)
    }
    
    func makeConstraints() {
        identifierTextField.snp.makeConstraints {
            $0.top.equalTo(super.safeAreaLayoutGuide).offset(20)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(identifierTextField.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
    }
}
