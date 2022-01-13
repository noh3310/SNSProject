//
//  ChangePasswordViewModel.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/09.
//

import Foundation
import RxRelay

class ChangePasswordViewModel {
    var currentPassword = BehaviorRelay<String>(value: "")
    var changePassword = BehaviorRelay<String>(value: "")
    var conformChangePassword = BehaviorRelay<String>(value: "")
    
    func changeUserPassword(completion: @escaping (APIStatus) -> Void) {
        APIService.postChangePassword(currentPassword: currentPassword.value, changePassword: changePassword.value, conformPassword: conformChangePassword.value) { user, error in
            if user == nil {
                print(error?.rawValue ?? "모름")
                completion(.fail)
                return
            }
            
            UserDefaults.standard.set("\(self.changePassword.value)", forKey: "password")
            completion(.success)
        }

    }
}
