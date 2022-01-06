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
    
    func postRegister(completion: @escaping (APIStatus) -> Void) {

        guard let jwt = UserDefaults.standard.string(forKey: "token") else { return }
        
        APIService.postRegister(text: text.value, jwt: jwt) { postRegister, error in
            guard let postRegister = postRegister else {
                print(error?.rawValue ?? "모름")
                completion(.fail)
                return
            }
            
            completion(.success)
        }
    }
}
