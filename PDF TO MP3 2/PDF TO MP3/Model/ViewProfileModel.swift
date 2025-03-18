//
//  ViewProfileModel.swift
//  PDF TO MP3
//
//  Created by SAIL L1 on 10/02/25.
//

import Foundation
struct ViewProfileModel: Codable {
    let status: Bool
    let message: String
    let data: [viewProfileData]

    enum CodingKeys: String, CodingKey {
        case status = "Status"
        case message, data
    }
}

// MARK: - Datum
struct viewProfileData: Codable {
    let id: Int
    let name, username, mobilePhone, email: String
    let position: String

    enum CodingKeys: String, CodingKey {
        case id, name, username
        case mobilePhone = "mobile_phone"
        case email
        case position = "POSITION"
    }
}
