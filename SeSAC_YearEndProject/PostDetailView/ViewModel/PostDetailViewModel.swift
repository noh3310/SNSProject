//
//  PostViewModel.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/06.
//

import Foundation
import RxRelay

class PostDetailViewModel {
    var comments = BehaviorRelay<Comments>(value: Comments())
    var postData = PublishRelay<Bearer>()
    
    var post = BehaviorRelay<Int>(value: 0)
    var commentText = BehaviorRelay<String>(value: "")
    var userID = BehaviorRelay<Int>(value: 0)
    
    func updatePostData() {
        fetchPostData {}
        commentList {}
    }
    
    func fetchPostData(completion: @escaping () -> Void) {
        APIService.postInformation(postID: post.value) { data, error in
            guard let data = data else {
                print(error?.rawValue ?? "모름")
                completion()
                return
            }
            
            self.postData.accept(data)
            completion()
        }
    }
    
    func commentList(completion: @escaping () -> Void) {
        APIService.postComments(post: post.value) { comments, error in
            guard let comments = comments else {
                print(error?.rawValue ?? "모름")
                completion()
                return
            }
            
            self.comments.accept(comments)
            completion()
        }
    }
    
    func registerComment(completion: @escaping (APIStatus) -> Void) {
        
        APIService.registerComment(comment: commentText.value, post: "\(post.value)") { comments, error in
            if comments == nil {
                print(error?.rawValue ?? "모름")
                completion(.fail)
                return
            }
            
            self.updatePostData()

            completion(.success)
        }
    }
    
    func deleteComments(post: Int, completion: @escaping (APIStatus) -> Void) {
        
        APIService.deleteComment(postID: post) { comment, error in
            if comment == nil {
                print(error?.rawValue ?? "모름")
                completion(.fail)
                return
            }

            self.updatePostData()
            
            completion(.success)
        }
    }
    
    func deletePost(completion: @escaping (APIStatus) -> Void) {
        
        APIService.deletePost(postID: post.value) { comment, error in
            if comment == nil {
                print(error?.rawValue ?? "모름")
                completion(.fail)
                return
            }
            
            self.updatePostData()

            completion(.success)
        }
    }
}
