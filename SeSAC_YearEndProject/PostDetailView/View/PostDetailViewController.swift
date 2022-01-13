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
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setBackButton()
        view.backgroundColor = .white
        
        DispatchQueue.global().async {
            self.viewModel.updatePostData()
        }
        
        if let bearer = viewModel.bearer {
//            mainView.fetchData(bearer)
        }
        
        setTableView()
        
        setNavigationBar()
       
        setCommentView()
        
        setPostData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updatePostData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.updatePostData()
    }
    
    func setNavigationBar() {
        let userId = UserDefaults.standard.integer(forKey: "id")
        viewModel.userID
            .filter { $0 == userId }
            .bind { _ in
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(self.setButtonClicked))
                self.navigationItem.rightBarButtonItem?.tintColor = .black
            }
            .disposed(by: disposeBag)
    }
    
    func setTableView() {
        mainView.tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.identifier)
        
        mainView.tableView
            .rx.itemSelected
          .subscribe(onNext: { indexPath in
              
              let userId = UserDefaults.standard.integer(forKey: "id")
              if self.viewModel.comments.value[indexPath.row].user.id == userId {
                  let row = self.viewModel.comments.value[indexPath.row]
                  
                  let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                  
                  let modify = UIAlertAction(title: "댓글 수정", style: .default) { action in
                      let vc = EditViewController()
                      vc.viewModel.state = .modifyComment
                      vc.viewModel.post = row.post.id
                      vc.viewModel.commentID = row.id
                      vc.viewModel.text.accept(row.comment)
                      self.navigationController?.pushViewController(vc, animated: true)
                  }
                  
                  let delete = UIAlertAction(title: "댓글 삭제", style: .default) { action in
                      
                      self.viewModel.deleteComments(post: row.id) { state in
                          if state == .success {
                              self.view.makeToast("삭제 성공")
                          } else {
                              self.view.makeToast("삭제 실패")
                          }
                      }
                  }
                  
                  let cancel = UIAlertAction(title: "취소", style: .cancel)
                  
                  alert.addAction(modify)
                  alert.addAction(delete)
                  alert.addAction(cancel)
                  
                  self.present(alert, animated: true, completion: nil)
              } else {
                  self.view.makeToast("내가 쓴 글이 아니에요")
              }
          })
          .disposed(by: disposeBag)
        
        viewModel.comments
            .asDriver(onErrorJustReturn: [])
            .drive(mainView.tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier) as! CommentTableViewCell

                cell.commentUserNameLabel.text = element.user.username
                cell.commentTextLabel.text = element.comment
                
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    func setPostData() {
        viewModel.postData
            .bind { bearer in
                print("postData")
                self.mainView.userNameLabel.text = bearer.user.username
                self.mainView.dateLabel.text = bearer.updatedAt
                self.mainView.textLabel.text = bearer.text
                self.mainView.commentLabel.text = "\(bearer.comments.count)개"
            }
            .disposed(by: disposeBag)
    }
    
    func setCommentView() {
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
                            self.viewModel.updatePostData()
                            self.view.makeToast("댓글 등록 성공")
                            
                        } else {
                            self.view.makeToast("댓글 등록 실패")
                        }
                    }
                } else {
                    self.view.makeToast("입력값이 없습니다.")
                }
            }
            .disposed(by: disposeBag)
    }
    
    @objc func setButtonClicked() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let modify = UIAlertAction(title: "글 수정", style: .default) { action in
            let vc = EditViewController()
            vc.viewModel.post = self.viewModel.post.value
            vc.viewModel.text.accept(self.viewModel.bearer?.text ?? "")
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let changePassword = UIAlertAction(title: "글 삭제", style: .default) { action in
            self.viewModel.deletePost { state in
                if state == .success {
                    self.view.makeToast("성공")
                    // 원래 지워야 하는데 지금 API 데이터개수 제한이 있어서 삭제를 못해보는중....
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.view.makeToast("실패")
                }
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(modify)
        alert.addAction(changePassword)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
}
