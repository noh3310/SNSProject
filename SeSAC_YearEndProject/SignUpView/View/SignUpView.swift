//
//  SignUpView.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/03.
//

import UIKit

class SignUpView: UIView, CustomViewProtocol {
    
    let emailTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "이메일을 입력하세요"
        return textfield
    }()
    
    let nicknameTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "닉네임을 입력하세요"
        return textfield
    }()
    
    let passwordTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "비밀번호를 입력하세요"
        return textfield
    }()
    
    let passwordConformTextField: CustomTextField = {
        let textfield = CustomTextField()
        textfield.placeholder = "비밀번호를 한번더 입력하세요"
        return textfield
    }()
    
    let registerButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("회원가입", for: .normal)
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
        self.addSubview(emailTextField)
        self.addSubview(nicknameTextField)
        self.addSubview(passwordTextField)
        self.addSubview(passwordConformTextField)
        self.addSubview(registerButton)
    }
    
    func makeConstraints() {
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(super.safeAreaLayoutGuide).offset(20)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
        passwordConformTextField.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
        registerButton.snp.makeConstraints {
            $0.top.equalTo(passwordConformTextField.snp.bottom).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
    }
    
}
