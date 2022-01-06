//
//  SignUpViewController.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/03.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {

    var mainView = SignUpView()
    
    var viewModel = SignUpViewModel()
    
    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        title = "회원가입"
        
        bindViewModel()
        
        mainView.registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
    }
    
    func bindViewModel() {
        viewModel.email.bind {
            self.mainView.emailTextField.text = $0
        }
        
        viewModel.nickname.bind {
            self.mainView.nicknameTextField.text = $0
        }
        
        viewModel.password.bind {
            self.mainView.passwordTextField.text = $0
        }
        
        viewModel.passwordConform.bind {
            self.mainView.passwordConformTextField.text = $0
        }
        
        // 뷰에서 일어나는 데이터 변환을 뷰 모델에다 전달해줌
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        mainView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordConformTextField.addTarget(self, action: #selector(passwordConformTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        viewModel.email.value = textField.text ?? ""
    }
    
    @objc func nicknameTextFieldDidChange(_ textField: UITextField) {
        viewModel.nickname.value = textField.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        viewModel.password.value = textField.text ?? ""
    }
    
    @objc func passwordConformTextFieldDidChange(_ textField: UITextField) {
        viewModel.passwordConform.value = textField.text ?? ""
    }
    
    @objc func registerButtonClicked() {
        viewModel.userRegister {
            print("클릭")
        }
    }
}
