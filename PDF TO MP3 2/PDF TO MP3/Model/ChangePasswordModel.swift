//
//  ChangePasswordModel.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 10/02/25.
//

import Foundation
struct ChangePasswordModel: Codable {
    let status: Bool
    let message: String
    let data: changePass

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case message, data
    }
}

// MARK: - DataClass
struct changePass: Codable {
    let user: Int
    let profilePic, name, username, passwords: String
    let mobilePhone, email, position: String

    enum CodingKeys: String, CodingKey {
        case user
        case profilePic = "profile_pic"
        case name, username, passwords
        case mobilePhone = "mobile_phone"
        case email
        case position = "POSITION"
    }
}
