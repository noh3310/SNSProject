//
//  EndPoint.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/03.
//

import Foundation
import UIKit

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum EndPoint {
    case signup
    case login
    case boards
    case boardDetail(id: Int)
    case comments
    case changePassword
}

extension EndPoint {
    var url: URL {
        switch self {
        case .signup:
            return .signup
        case .login:
            return .login
        case .boards:
            return .boards
        case .boardDetail(id: let id):
            return .boardsDetail(number: id)
        case .comments:
            return .comments
        case .changePassword:
            return .changePassword
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:1231/"
    
    static func makeEndpoint(_ endpoint: String) -> URL {
        return URL(string: baseURL + endpoint)!
    }
    
    // 로그인 주소를 리턴해줌
    static var login: URL {
        return makeEndpoint("auth/local")
    }
    
    static var signup: URL {
        return makeEndpoint("auth/local/register")
    }
    
    static var boards: URL {
        return makeEndpoint("posts")
    }
    
    static func post(number: Int) -> URL {
        return makeEndpoint("posts/\(number)")
    }
    
    static func modifyComment(number: Int) -> URL {
        return makeEndpoint("comments/\(number)")
    }
    
    static func boardsDetail(number: Int) -> URL {
        return makeEndpoint("boards/\(number)")
    }
    
    static var comments: URL {
        return makeEndpoint("comments")
    }
    
    static var changePassword: URL {
        return makeEndpoint("custom/change-password")
    }
}

extension URLSession {
    
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult
    func dataTask(_ endpoint: URLRequest, handler: @escaping Handler) -> URLSessionDataTask {
        
        let task = dataTask(with: endpoint, completionHandler: handler)
        task.resume()
        
        return task
    }
    
    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
        
        session.dataTask(endpoint) { data, response, error in
//            print("\(String(describing: data))")
//            print(response)
//            print(error)
            
            DispatchQueue.main.async {
                // 에러가 nil인 경우 일찍 리턴을 해라
                guard error == nil else {
                    completion(nil, .failed)
                    return
                }
                
                // 데이터가 nil이라면 일찍 리턴을 해라
                guard let data = data else {
                    completion(nil, .noData)
                    return
                }
                
                // response가 nil이 아닌지, 그리고 타입캐스팅이 잘 되는지 확인
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                // 200번으로 올바르게 왔는지
                guard response.statusCode == 200 else {
                    if response.statusCode == 401 {
                        DispatchQueue.main.async {
                            UIViewController.gotoLogin()
                        }
                    }
                    completion(nil, .failed)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(T.self, from: data)
                    // 에러가 없기 때문에 nil 리턴
                    completion(data, nil)
                } catch {
                    completion(nil, .invalidData)
                }
                
            }
            
        }
    }
}
