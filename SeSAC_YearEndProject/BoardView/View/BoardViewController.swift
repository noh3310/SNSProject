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
        
        title = "새싹농장"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(setButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        
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
        
        mainView.editButton.rx.tap
            .bind {
                self.navigationController?.pushViewController(EditViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBearerList() // 삭제하거나, 수정했을 때 업데이트
    }
    
    func setBearerList() {
        viewModel.bearerList { state in
            if state == .tokenExpire {
                UserDefaults.standard.removeObject(forKey: "token".description)
                let alert = UIAlertController(title: "토큰이 만료되었습니다.", message: "확인 버튼을 누르면 로그인 화면으로 돌아갑니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default) { action in
                    let rootVC = UINavigationController(rootViewController: SignInViewController())
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                    sceneDelegate.window?.rootViewController = rootVC
                }
                alert.addAction(ok)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func setButtonClicked() {
        let alert = UIAlertController(title: "원하는 설정을 클릭하세요.", message: nil, preferredStyle: .actionSheet)
        
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
