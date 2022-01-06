//
//  PostViewModel.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/06.
//

import Foundation
import RxRelay

class PostDetailViewModel {
//    var post: BehaviorRelay<Bearer>?
    var test = PublishRelay<Bearer>()
    var bearer: Bearer?
    var comments = BehaviorRelay<Comments>(value: [])
    
    var post = BehaviorRelay<Int>(value: 0)
    var commentText = BehaviorRelay<String>(value: "")
    
    func commentList(completion: @escaping () -> Void) {
        
        guard let jwt = UserDefaults.standard.string(forKey: "token") else { return }
        
        APIService.postComments(post: "\(post.value)", jwt: jwt) { comments, error in
            
            // userData가 옵셔널 타입이기 때문에 옵셔널 해제를 해줘야함
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
        print("commentText.value = \(commentText.value)")
        print("post.value = \(post.value)")
        APIService.registerComment(comment: commentText.value, post: "\(post.value)") { comments, error in
            // userData가 옵셔널 타입이기 때문에 옵셔널 해제를 해줘야함
            guard let comments = comments else {
                print(error?.rawValue ?? "모름")
                completion(.fail)
                return
            }

            completion(.success)
        }
    }
}
