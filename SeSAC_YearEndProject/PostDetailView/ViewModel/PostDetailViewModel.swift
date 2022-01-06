//
//  PostViewModel.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/06.
//

import Foundation
import RxRelay

class PostDetailViewModel {
    var post: BehaviorRelay<Bearer>?
    var test = PublishRelay<Bearer>()
}
