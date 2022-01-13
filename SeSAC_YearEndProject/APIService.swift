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
    case changePassword
    
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
        case .changePassword:
            return "changePassword"
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
        URLSession.request(endpoint: request, completion: completion)    }
    
    static func register(username: String, email: String, password: String, completion: @escaping (User?, APIError?) -> Void) {
        
        var request = URLRequest(url: EndPoint.signup.url)
        request.httpMethod = Method.POST.rawValue
        // 이렇게 처리할 수도 있고, 딕셔너리로 쓸 수도 있음
        request.httpBody = "username=\(username)&email=\(email)&password=\(password)".data(using: .utf8, allowLossyConversion: false)
        
        // 등록하고 이렇게 보여주기
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func boards(completion: @escaping (Bearers?, APIError?) -> Void) {
        var request = URLRequest(url: EndPoint.boards.url)
        
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func postRegister(text: String, completion: @escaping (PostRegister?, APIError?) -> Void) {
        var request = URLRequest(url: EndPoint.boards.url)
        request.httpMethod = Method.POST.rawValue
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func modifyPost(post: Int, text: String, completion: @escaping (PostRegister?, APIError?) -> Void) {
        var request = URLRequest(url: URL.post(number: post))
        request.httpMethod = Method.PUT.rawValue
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = "text=\(text)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func postComments(post: Int, completion: @escaping (Comments?, APIError?) -> Void) {
        var request = URLRequest(url: URL(string: URL.baseURL + "comments?post=\(post)")!)
        
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
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
    
    static func postChangePassword(currentPassword: String, changePassword: String, conformPassword: String, completion: @escaping (ChangePasswordUser?, APIError?) -> Void) {
        var request = URLRequest(url: EndPoint.changePassword.url)
        request.httpMethod = Method.POST.rawValue
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = "currentPassword=\(currentPassword)&newPassword=\(changePassword)&confirmNewPassword=\(conformPassword)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func modifyComments(postID: Int, commentID: Int, text: String, completion: @escaping (PostComment?, APIError?) -> Void) {
        print("postID = ", postID)
        print("commentID = ", commentID)
        var request = URLRequest(url: URL.modifyComment(number: commentID))
        request.httpMethod = Method.PUT.rawValue
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        request.httpBody = "comment=\(text)&post=\(postID)".data(using: .utf8, allowLossyConversion: false)
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func deleteComment(postID: Int, completion: @escaping (PostComment?, APIError?) -> Void) {
        var request = URLRequest(url: URL.modifyComment(number: postID))
        
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func postInformation(postID: Int, completion: @escaping (Bearer?, APIError?) -> Void) {
        var request = URLRequest(url: URL.post(number: postID))

        request.httpMethod = Method.GET.rawValue
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")

        URLSession.request(endpoint: request, completion: completion)
    }
    
    static func deletePost(postID: Int, completion: @escaping (Bearer?, APIError?) -> Void) {
        var request = URLRequest(url: URL.post(number: postID))
        
        request.httpMethod = Method.DELETE.rawValue
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        URLSession.request(endpoint: request, completion: completion)
    }
}
