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
              vc.viewModel.bearer = self?.viewModel.list.value[indexPath.row]
              vc.viewModel.post.accept((self?.viewModel.list.value[indexPath.row].id)!)
              self?.navigationController?.pushViewController(vc, animated: true)
          }).disposed(by: disposeBag)
        
        mainView.editButton.rx.tap
            .bind {
                self.navigationController?.pushViewController(EditViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    func setBearerList() {
        viewModel.bearerList { state in
            if state == .tokenExpire {
                UserDefaults.standard.removeObject(forKey: "token".description)
                let alert = UIAlertController(title: "토큰이 만료되었습니다.", message: "확인 버튼을 누르면 로그인 화면으로 돌아갑니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default) { action in
                    let rootVC = SignInViewController()
                    let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                    sceneDelegate.window?.rootViewController = rootVC
                }
                alert.addAction(ok)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
