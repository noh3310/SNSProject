//
//  APIService.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/03.
//

import Foundation
import FileProvider

enum APIError: Error {
    case invalidResponse
    case noData
    case failed
    case invalidData
    case tokenExpire
    
    var rawValue: String {
        switch self {
        case .invalidResponse:
            return "invalidResponse"
        case .noData:
            return "noData"
        case .failed:
            return "failed"
        case .invalidData:
            return "invalidData"
        case .tokenExpire:
            return "tokenExpire"
        }
    }
}

class APIService {
    
    static var jwt: String {
        let jwt = UserDefaults.standard.string(forKey: "token")
        return jwt!
    }
    
    static func login(identifier: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: EndPoint.login.url)
        request.httpMethod = Method.POST.rawValue
        // 이렇게 처리할 수도 있고, 딕셔너리로 쓸 수도 있음
        request.httpBody = "identifier=\(identifier)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        // 훨씬 간편하게 사용할 수 있다.
        URLSession.request(endpoint: request, completion: completion)
//        URLSession.request(.shared, endpoint: request, completion: completion)
    }
    
    static func register(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: EndPoint.signup.url)
        request.httpMethod = Method.POST.rawValue
        // 이렇게 처리할 수도 있고, 딕셔너리로 쓸 수도 있음
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        // 등록하고 이렇게 보여주기
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func boards(jwt: String, completion: @escaping (Bearers?, APIError?) -> Void) {
        var request = URLRequest(url: EndPoint.boards.url)
        
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func postRegister(text: String, jwt: String, completion: @escaping (PostRegister?, APIError?) -> Void) {
        var request = URLRequest(url: EndPoint.boards.url)
        request.httpMethod = Method.POST.rawValue
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func postComments(post: String, jwt: String, completion: @escaping (Comments?, APIError?) -> Void) {
        var request = URLRequest(url: EndPoint.boards.url)
        request.httpMethod = Method.POST.rawValue
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = "post=\(post)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func registerComment(comment: String, post: String, completion: @escaping (PostComment?, APIError?) -> Void) {
        var request = URLRequest(url: EndPoint.comments.url)
        request.httpMethod = Method.POST.rawValue
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = "comment=\(comment)&post=\(post)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
}
