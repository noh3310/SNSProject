//
//  SignInViewModel.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/04.
//

import Foundation

class SignInViewModel {
    var identifier: Observable<String> = Observable("aaaaab")
    var password: Observable<String> = Observable("aaaaab")
    
    func userLogin(completion: @escaping (APIStatus) -> Void) {
        // 1. 입력한 값이 없는지, 이메일 형식 맞는지(정규식), 다른것들이 맞는지 무선 확인
        APIService.login(identifier: identifier.value, password: password.value) { userData, error in
            print("로그인 시도")
            // userData가 옵셔널 타입이기 때문에 옵셔널 해제를 해줘야함
            guard let userData = userData else {
                print(error?.rawValue ?? "옵셔널해제 실패")
                print("실패")
                completion(.fail)
                return
            }
            
            print("로그인 성공")
            
            // 로그인하면 UserDefaults true로 전환하기
            UserDefaults.standard.set(true, forKey: "signUp")
            
            // 토큰값 저장
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "nickname")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            completion(.success)
        }
    }
}
