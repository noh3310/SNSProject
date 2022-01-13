//
//  ChangePasswordView.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/09.
//

import UIKit
import SnapKit

class ChangePasswordView: UIView, CustomViewProtocol {
    
    let currentPasswordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "현재 비밀번호"
        return textField
    }()
    
    let changePasswordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "변경할 비밀번호"
        return textField
    }()
    
    let conformChangePasswordTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "변경할 비밀번호 한번 더 입력"
        return textField
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
        self.addSubview(currentPasswordTextField)
        self.addSubview(changePasswordTextField)
        self.addSubview(conformChangePasswordTextField)
    }
    
    func makeConstraints() {
        currentPasswordTextField.snp.makeConstraints {
            $0.top.equalTo(super.safeAreaLayoutGuide).offset(20)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
        changePasswordTextField.snp.makeConstraints {
            $0.top.equalTo(currentPasswordTextField.snp.bottom).offset(20)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
        
        conformChangePasswordTextField.snp.makeConstraints {
            $0.top.equalTo(changePasswordTextField.snp.bottom).offset(20)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerX.equalToSuperview()
        }
    }
    
}
