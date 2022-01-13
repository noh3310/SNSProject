//
//  BoardViewController.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/04.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

class BoardViewController: UIViewController {
    
    let mainView = BoardView()
    
    let viewModel = BoardViewModel()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        setNavigationBar()
        
        setTableView()
        
        setEditButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBearerList() // 삭제하거나, 수정했을 때 업데이트
    }
    
    func setNavigationBar() {
        title = "새싹농장"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(setButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    func setTableView() {
        mainView.tableView.register(BoardTableViewCell.self, forCellReuseIdentifier: BoardTableViewCell.identifier)
        
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
          .subscribe(onNext: { indexPath in
              let vc = PostDetailViewController()
              vc.viewModel.post.accept((self.viewModel.list.value[indexPath.row].id))
              vc.viewModel.userID.accept(self.viewModel.list.value[indexPath.row].user.id)
              self.navigationController?.pushViewController(vc, animated: true)
          })
          .disposed(by: disposeBag)
    }
    
    func setEditButton() {
        mainView.editButton.rx.tap
            .bind {
                let vc = EditViewController()
                vc.viewModel.toastText
                    .bind { value in
                        self.view.makeToast(value)
                    }
                    .disposed(by: self.disposeBag)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func setBearerList() {
        viewModel.bearerList { }
    }
    
    @objc func setButtonClicked() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let logout = UIAlertAction(title: "로그아웃", style: .default) { action in
            let rootVC = UINavigationController(rootViewController: SignInViewController())
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
            sceneDelegate.window?.rootViewController = rootVC
        }
        
        let changePassword = UIAlertAction(title: "비밀번호 변경", style: .default) { action in
            self.navigationController?.pushViewController(ChangePasswordViewController(), animated: true)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(logout)
        alert.addAction(changePassword)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}
