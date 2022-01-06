//
//  SignInViewController.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/03.
//

import UIKit
import Toast

class SignInViewController: UIViewController {
    
    let mainView = SignInView()
    
    let viewModel = SignInViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        bindViewModel()
        
        mainView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    func bindViewModel() {
        viewModel.identifier.bind {
            self.mainView.identifierTextField.text = $0
        }
        
        viewModel.password.bind {
            self.mainView.passwordTextField.text = $0
        }
        
        // 뷰에서 일어나는 데이터 변환을 뷰 모델에다 전달해줌
        mainView.identifierTextField.addTarget(self, action: #selector(identifierTextFieldDidChange(_:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    @objc func identifierTextFieldDidChange(_ textField: UITextField) {
        viewModel.identifier.value = textField.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        viewModel.password.value = textField.text ?? ""
    }
    
    @objc func loginButtonClicked() {
        viewModel.userLogin { state in
            print("rawValue = \(state.rawValue)")
            if state == .success {
                self.navigationController?.pushViewController(BoardViewController(), animated: true)
            } else {
                self.view.makeToast("로그인에 실패했습니다.")
            }
        }
    }
}
