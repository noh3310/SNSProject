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
        
        title = "새싹농장 글쓰기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(completionButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationController?.setBackButton()

        view.backgroundColor = .white
        
        viewModel.text
            .asDriver()
            .drive(mainView.textView.rx.text)
//            .bind(to: mainView.textView.rx.text)     // 위 두줄이랑 같은 코드, ui에서는 위에가 조금 더 적합함
            .disposed(by: disposeBag)
        
        setRxKeyboard()
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
        
        viewModel.postRegister { status in
            if status == .success {
                self.view.makeToast("등록되었습니다.")
                self.navigationController?.popViewController(animated: true)
            } else {
                self.view.makeToast("등록에 실패했습니다.")
            }
        }
        
    }
}
