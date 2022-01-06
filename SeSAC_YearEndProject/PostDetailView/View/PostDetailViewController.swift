//
//  PostDetailViewController.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/06.
//

import UIKit
import RxSwift
import RxCocoa

class PostDetailViewController: UIViewController {
    
    let viewModel = PostDetailViewModel()
    
    let mainView = PostDetailView()
    
    var disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        if let bearer = viewModel.bearer {
            mainView.fetchData(bearer)
        }
        
        mainView.commentView.textField.rx.text
            .orEmpty
            .bind(to: viewModel.commentText)
            .disposed(by: disposeBag)
        
        
        mainView.commentView.registerButton.rx.tap
            .bind { _ in
                self.view.endEditing(true)
                if (self.mainView.commentView.textField.text!.isValidString() == true) {
                    self.viewModel.registerComment { state in
                        if state == .success {
                            self.view.makeToast("성공")
                        } else {
                            self.view.makeToast("실패")
                        }
                    }
                } else {
                    self.view.makeToast("입력값이 없습니다.")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func setComments() {
        viewModel.commentList {
            
        }
    }
    
}
