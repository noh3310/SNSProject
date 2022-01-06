//
//  BoardViewController.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/04.
//

import UIKit
import RxSwift
import RxCocoa

class BoardViewController: UIViewController {
    
    let mainView = BoardView()
    
    let viewModel = BoardViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBearerList()
        
        mainView.tableView.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.identifier)
        
        // viewModel data -> tableView ??
        viewModel.list
            .asDriver(onErrorJustReturn: [])
            .drive(mainView.tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: BoardTableViewCell.identifier) as! BoardTableViewCell
                cell.nicknameLabel.text = element.user.username
                cell.contentLabel.text = element.text
                cell.dateLabel.text = element.createdAt
                cell.commentLabel.text = "\(element.comments.count)"
                
                return cell
            }
            .disposed(by: disposeBag)
        
        mainView.tableView
            .rx.itemSelected
          .subscribe(onNext: { [weak self] indexPath in
              let vc = PostDetailViewController()
              vc.viewModel.post?.accept( (self?.viewModel.list.value[indexPath.row])!)
              vc.viewModel.test.accept((self?.viewModel.list.value[indexPath.row])!)
              self?.navigationController?.pushViewController(vc, animated: true)
          }).disposed(by: disposeBag)
        
        
        mainView.editButton.addTarget(self, action: #selector(editButtonClicked), for: .touchUpInside)
    }
    
    func setBearerList() {
        viewModel.bearerList {
            // 코드 없으니 나중에 수정하기
        }
    }
    
    @objc func editButtonClicked() {
        self.navigationController?.pushViewController(EditViewController(), animated: true)
    }
}
