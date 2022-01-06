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
        
        print("여기 들어왔다")
        print((viewModel.post?.value.text ?? "기본값") as String)
        viewModel.test.subscribe({ bearer in
            print("asfasfsadfsadfaf")
            print(bearer.element?.comments.count ?? "123")
        })
            .disposed(by: disposeBag)
//        viewModel.post?.value.comments
    }
    
    
    
}
