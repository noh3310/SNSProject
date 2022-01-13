//
//  EditViewModel.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/06.
//

import Foundation
import RxRelay

class EditViewModel {
    var text = BehaviorRelay<String>(value: "")
    var post: Int?
    var state = EditState.createPost
    var commentID: Int?
    
    func postRegister(completion: @escaping (APIStatus) -> Void) {
        
        APIService.postRegister(text: text.value) { postRegister, error in
            if postRegister == nil {
                print(error?.rawValue ?? "모름")
                completion(.fail)
                return
            }
            
            completion(.success)
        }
    }
    
    func postModify(completion: @escaping (APIStatus) -> Void) {
        guard let post = post else { return }

        APIService.modifyPost(post: post, text: text.value) { postRegister, error in
            if postRegister == nil {
                print(error?.rawValue ?? "모름")
                completion(.fail)
                return
            }
            
            completion(.success)
        }
    }
    
    
    func modifyComment(completion: @escaping (APIStatus) -> Void) {
        guard let post = post else { return }
        guard let commentID = commentID else { return }
        
        APIService.modifyComments(postID: post, commentID: commentID, text: text.value) { post, error in
            if post == nil {
                print(error?.rawValue ?? "모름")
                completion(.fail)
                return
            }
            
            completion(.success)
        }
    }
}
