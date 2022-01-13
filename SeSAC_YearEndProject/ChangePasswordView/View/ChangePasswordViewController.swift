//
//  ChangePasswordViewController.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/09.
//

import UIKit
import RxSwift
import Toast

class ChangePasswordViewController: UIViewController {
    
    let mainView = ChangePasswordView()
    
    let viewModel = ChangePasswordViewModel()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView()
        bindViewModel()
    }
    
    func setView() {
        view.backgroundColor = .white
        
        title = "비밀번호 변경"
        navigationController?.setBackButton()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "변경하기", style: .plain, target: self, action: #selector(changePasswordButtonClicked))
        
    }
    
    func bindViewModel() {
        mainView.currentPasswordTextField.rx.text
            .orEmpty
            .bind(to: self.viewModel.currentPassword)
            .disposed(by: disposeBag)
        
        mainView.changePasswordTextField.rx.text
            .orEmpty
            .bind(to: self.viewModel.changePassword)
            .disposed(by: disposeBag)
        
        mainView.conformChangePasswordTextField.rx.text
            .orEmpty
            .bind(to: self.viewModel.conformChangePassword)
            .disposed(by: disposeBag)
    }
    
    @objc func changePasswordButtonClicked() {
        view.endEditing(true)
        viewModel.changeUserPassword { state in
            if state == .success {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.view.makeToast("실패")
            }
        }
    }
    
}
