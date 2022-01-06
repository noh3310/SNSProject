//
//  User.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/03.
//

import Foundation


// MARK: - User
struct User: Codable {
    let jwt: String
    let user: UserClass
}

struct UserClass: Codable {
    let id: Int
    let username, email: String
//    let provider: String
//    let confirmed: Bool
//    let blocked: Bool?
//    let role: Int
//    let createdAt, updatedAt: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, username, email, provider, confirmed, blocked, role
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//    }
}

//// MARK: - Role
//struct Role: Codable {
//    let id: Int
//    let name, roleDescription, type: String
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case roleDescription = "description"
//        case type
//    }
//}
//
//enum Provider: String, Codable {
//    case local = "local"
//}
