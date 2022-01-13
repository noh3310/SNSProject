//
//  ChangePasswordModel.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/10.
//

import Foundation

// MARK: - ChangePasswordUser
struct ChangePasswordUser: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let blocked: Bool?
    let role: Role
    let createdAt, updatedAt: String
    let posts: [Post]
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, blocked, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case posts, comments
    }
}

// MARK: - Role
struct Role: Codable {
    let id: Int
    let name, roleDescription, type: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case roleDescription = "description"
        case type
    }
}
