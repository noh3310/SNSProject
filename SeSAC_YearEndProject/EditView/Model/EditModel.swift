//
//  EditModel.swift
//  SeSAC_YearEndProject
//
//  Created by 노건호 on 2022/01/06.
//

import Foundation

// MARK: - PostRegister
struct PostRegister: Codable {
    let id: Int
    let text: String
    let user: UserInfo
    let createdAt, updatedAt: String
    let comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, text, user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case comments
    }
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let id: Int
    let username, email, provider: String
    let confirmed: Bool
    let blocked: Bool?
    let role: Int
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, username, email, provider, confirmed, blocked, role
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
