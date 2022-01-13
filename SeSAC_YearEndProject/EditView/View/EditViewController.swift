//
//  EditViewController.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/05.
//

import UIKit
import RxKeyboard
import RxSwift
import Toast

class EditViewController: UIViewController {
    
    let mainView = EditView()
    
    let viewModel = EditViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setNavigationBar()
        
        textViewBind()
        
        setRxKeyboard()
    }
    
    func setNavigationBar() {
        title = "새싹농장 글쓰기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(completionButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationController?.setBackButton()
    }
    
    func textViewBind() {
        viewModel.text
            .asDriver()
            .drive(mainView.textView.rx.text)
            .disposed(by: disposeBag)
        
        mainView.textView.rx.text
            .orEmpty
            .bind(to: viewModel.text)
            .disposed(by: disposeBag)
    }
    
    func setRxKeyboard() {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        let bottomHeight = window!.safeAreaInsets.bottom
        RxKeyboard.instance.visibleHeight
            .skip(1)
            .drive(onNext: { keyboardVisibleHeight in
                self.mainView.textView.snp.makeConstraints {
                    $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(keyboardVisibleHeight - bottomHeight)
                }
            })
            .disposed(by: disposeBag)
    }
    
    @objc func completionButtonClicked() {
        self.view.endEditing(true)
        
        if !viewModel.text.value.isValidString() {
            self.view.makeToast("입력값이 없습니다.")
            return
        }
        
        switch viewModel.state {
        case .createPost:
            viewModel.postRegister { status in
                if status == .success {
                    self.viewModel.toastText.accept("등록을 성공했습니다.")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.view.makeToast("등록에 실패했습니다.")
                }
            }
        case .modifyPost:
            viewModel.postModify { status in
                if status == .success {
                    self.viewModel.toastText.accept("수정에 성공했습니다.")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.view.makeToast("수정에 실패했습니다.")
                }
            }
        case .modifyComment:
            viewModel.modifyComment { status in
                if status == .success {
                    self.viewModel.toastText.accept("수정에 성공했습니다.")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.view.makeToast("수정에 실패했습니다.")
                }
            }
        }
    }
}
